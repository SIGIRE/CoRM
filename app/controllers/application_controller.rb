# encoding: utf-8
##

require 'rubygems'
require 'zip'
require 'pathname'

# Main Controller (for protected pages)
#
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :getAbility
  before_filter :get_locale
  before_filter :get_previous_url, :only => [:edit, :new] 


  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to main_app.root_url, :alert => exception.message
    redirect_to :back, :error => t('app.cancan.messages.access_error')
  end
  
    
  def send_csv_backup_file
    dirname = "#{Rails.root}/#{CSV_BACKUP_PATH}"
    if !Dir.exists?(dirname) then Dir.mkdir(dirname) else FileUtils.rm_rf(Dir.glob(dirname + '/*')) end
    
    tables = ActiveRecord::Base.connection.tables.reject { |table| ['schema_info', 'schema_migrations'].include?(table) }
    tables.each do |table|
            table_column_names = ActiveRecord::Base.connection.columns(table).map { |c| c.name }
            io = File.new("#{dirname}/#{table}.csv", "w+")
            io.write(table_column_names.to_csv)
            id = table_column_names.first # colonne ID = première colonne
            boolean_columns = SerializationHelper::Utils.boolean_columns(table)

            query = Arel::Table.new(table).order(id).project(Arel.sql('*'))
            records = ActiveRecord::Base.connection.select_all(query)
            records = SerializationHelper::Utils.convert_booleans(records, boolean_columns)
            records = SerializationHelper::Utils.unhash_records(records, table_column_names)
            records.each do |record|
              io.write(record.to_csv)
            end # end records
    end # end table
    
    t = Tempfile.new(ZIP_CSV_TEMPFILE)
    Zip::OutputStream.open(t.path) { |zos| }
    Zip::File.open(t.path, Zip::File::CREATE) do |z|
      # Ajout du dossier /tmp/csv
      directory_pathname = Pathname.new(dirname)
      Dir[File.join(dirname,'**', '**')].each do |file|
        file_pathname = Pathname.new(file)
        file_relative_pathname = file_pathname.relative_path_from(directory_pathname)                
        z.add(file_relative_pathname,file)
      end # end file
      # Ajout du dossier /public/
      directory_pathname = Pathname.new("#{Rails.root}/#{PAPERCLIP_BACKUP_PATH}")
      Dir[File.join("#{Rails.root}/#{PAPERCLIP_BACKUP_PATH}",'**', '**')].each do |file|
        file_pathname = Pathname.new(file)
        file_relative_pathname = file_pathname.relative_path_from(directory_pathname)                   
        z.add(file_relative_pathname,file)
      end # end file                  
    end # end z
    zip_data = File.read(t.path)
    send_data(zip_data, :type => 'application/zip', :filename => CORM_CSV_FILE)
    t.close
    t.unlink
  end
  
  
  
  
  def send_yaml_backup_file
    dirname = "#{Rails.root}/#{YAML_BACKUP_PATH}"
    if !Dir.exists?(dirname) then Dir.mkdir(dirname) else FileUtils.rm_rf(Dir.glob(dirname + '/*')) end
    # Sauvegarde du fichier YAML
    ENV['class'] = "YamlDb::Helper"
    format_class = ENV['class'] || "YamlDb::Helper"
    helper = format_class.constantize
    SerializationHelper::Base.new(helper).dump "#{YAML_BACKUP_PATH}/#{YAML_BACKUP_FILE}"		
    
    t = Tempfile.new(ZIP_YAML_TEMPFILE)
    Zip::OutputStream.open(t.path) { |zos| }
    Zip::File.open(t.path, Zip::File::CREATE) do |z|
      # Ajout du dossier /tmp/yaml
      directory_pathname = Pathname.new(dirname)
      Dir[File.join(dirname,'**', '**')].each do |file|
        file_pathname = Pathname.new(file)
        file_relative_pathname = file_pathname.relative_path_from(directory_pathname)
        z.add(file_relative_pathname,file)
      end # end file
      # Ajout du dossier /public/
      directory_pathname = Pathname.new("#{Rails.root}/#{PAPERCLIP_BACKUP_PATH}")
      Dir[File.join("#{Rails.root}/#{PAPERCLIP_BACKUP_PATH}",'**', '**')].each do |file|
        file_pathname = Pathname.new(file)
        file_relative_pathname = file_pathname.relative_path_from(directory_pathname)                   
        z.add(file_relative_pathname,file)
      end # end file                  
    end # end z
    zip_data = File.read(t.path)
    send_data(zip_data, :type => 'application/zip', :filename => CORM_YAML_FILE)
    t.close
    t.unlink		
  end  
  

  private
  def getAbility
    @ability = Ability.new(current_user)
  end
  
  def get_locale
    I18n.locale = current_user.locale unless current_user.nil? || current_user.locale.blank?
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_url
  end
  
  def get_previous_url
    session[:return_to] = request.referer  
  end
  

  
end
