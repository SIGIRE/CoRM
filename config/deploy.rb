require 'bundler/capistrano'
set :user, "root"
set :application, "CRM demo"
set :deploy_to, "/webapps/crm/"
set :repository,  "git@git.sigire.net:/home/git/crm.git"
set :branch,  "master"
set :keep_releases, 20

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "demo-crm.sigire.net"                          # Your HTTP server, Apache/etc
role :app, "demo-crm.sigire.net"                          # This may be the same as your `Web` server
role :db,  "demo-crm.sigire.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   
   desc "Symlink shared configs and folders on each release"
   task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
   end
   
   desc "Change owner of the tmp folder"
   task :change_owner_tmp do
    run "chown -R apache:apache #{release_path}/tmp"
   end   
   
end

before "deploy:assets:precompile", "deploy:symlink_shared" 
after 'deploy:update_code', 'deploy:migrate', 'deploy:change_owner_tmp'
# after "deploy:restart", "deploy:cleanup"

set :deploy_via, :remote_cache
set :ssh_options, {:forward_agent => true}

default_run_options[:pty] = true
