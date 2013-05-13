#!bin/env ruby
# encoding utf-8

require 'bundler/capistrano'
require './config/CORM_Object.rb'

# 0: important, 1:info, 2: debug, 3: trace, 4: MAX-LEVEL
logger.level = 1

logger.log(0, '****************************************')
logger.log(0, '*           CORM Capistrano            *')
logger.log(0, '****************************************')

deploy_json = JSON(File.read('./config/deploy.json'))
servers = deploy_json['servers']
hostnames = Array.new

def createObject(o, depth)
    object = Hash.new
    o.each do |index, value|
        if (value.is_a? Hash)
            object[index.to_sym] = createObject(o[index], depth+1)
        elsif (value.is_a? String)
            object[index.to_sym] = (value[0] == ':' ? value[1..value.length].to_sym : value)
        else
            object[index.to_sym] = value
        end
    end
    return object
end

# set all capistrano variables
deploy_json['deployement'].each do |index, value|
    if (value.is_a? Hash)
        set index.to_sym, createObject(value, 0)
    elsif (value.is_a? String)
       set index.to_sym, (value[0] == ':' ? value[1..value.length].to_sym : value)
    else
        set index.to_sym, value
    end
end


# get all servers
servers.each do |hostname, content|
    if (defined? servers[hostname]['enabled'])
        if (servers[hostname]['enabled'] == true)
          hostnames.push(hostname)
          role :web, hostname
          role :app, hostname
          role :db, hostname, :primary => true
          logger.log(1, "LOAD SERVER: #{hostname}")
        else
            logger.log(0, "FAIL LOAD SERVER: #{hostname}")
        end
    else
        logger.log(0, "FAIL LOAD SERVER: #{hostname}")
    end
end

# Ask version number
version = Capistrano::CLI.ui.ask("Enter version: ")
bon = Capistrano::CLI.ui.ask("[B]uild or [N]ightly ? ")
corm = Hash.new
if(version.length == 0)
    corm = CORM_Object.get
    version = corm[:version].split(' ')[0]
end
if (bon.length > 0)
    bon = bon.downcase == 'b' ? 'build' : 'nightly'
else
    bon = 'nightly'
end
logger.log(0, "VERSION: #{version.to_s} (#{bon})")

namespace :deploy do
    task :start do
        hostname = capture("echo $CAPISTRANO:HOST$").strip
        logger.log(0, "STARTING deployement to #{hostname}")
    end
    task :stop do
        hostname = capture("echo $CAPISTRANO:HOST$").strip
        logger.log(0, "STOPPING deployement to #{hostname}")
    end
   
    task :update_code, :except=>{:no_release=>true} do 
        hostname = capture("echo $CAPISTRANO:HOST$").strip
        logger.log(0, "UPDATING code to #{hostname}")
    end
   
    task :finalize_update, :roles => :app do
        logger.log(0, "TRANSFER CORM.json to #{hostname}")
        hostname = capture("echo $CAPISTRANO:HOST$").strip
        logger.log(2, "LOAD Corm.json")
        corm[hostname] = Hash.new
        path = File.join(release_path, 'config', 'CORM.json')
        json_string = File.read('./config/CORM.json')
        json_object = JSON.parse(json_string)
        corm[hostname] = CORM_Object.createObject(json_object, 0, false)
        corm[hostname]['version'] = "#{version} (#{bon})"
        corm[hostname]['host'] = hostname
        if (!corm[hostname]['mail'].nil?)
            corm[hostname]['mail'].each do |index, value|
                if (defined? servers[hostname][index])
                    corm[hostname]['mail'][index] = servers[hostname]['mail'][index]
                end
            end
        end
        corm.save('./tmp/CORM_#{hostname}.json')

        transfer(:up, "./tmp/CORM_#{hostname}.json", "#{release_path}/config/CORM.json", { :hosts => hostname })
        
        logger.log(0, "TRANSFERED CORM.json to #{hostname}")
    end
   
   task :restart, :roles => :app do
     hostname = capture("echo $CAPISTRANO:HOST$").strip
     logger.log(0, "RESTARTING apache to #{hostname}") 
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     File.delete("./tmp/CORM_#{hostname}.json")
   end
   
   desc "Symlink shared configs and folders on each release"
   task :symlink_shared do
    hostname = capture("echo $CAPISTRANO:HOST$").strip
    logger.log(0, "CREATE Symlinks to #{hostname}")
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    run "ln -nfs #{shared_path}/system #{release_path}/public/system"
   end
   
   desc "Change owner of the tmp folder"
   task :change_owner_tmp do
    hostname = capture("echo $CAPISTRANO:HOST$").strip
    logger.log(0, "RUNNING CHOWN to #{hostname}") 
    run "chown -R apache:apache #{deploy_to}"
   end
end

before 'deploy:assets:precompile', 'deploy:symlink_shared'
after 'deploy:update_code', 'deploy:migrate', 'deploy:change_owner_tmp'

default_run_options[:pty] = true

