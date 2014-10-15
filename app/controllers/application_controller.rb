# encoding: utf-8

##
# Main Controller (for protected pages)
#
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :getAbility
  before_filter :get_locale

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to main_app.root_url, :alert => exception.message
    redirect_to :back, :error => t('app.cancan.messages.access_error')
  end
  
    
  def send_csv_backup_file
		#t = Temfile.new("CoRM-csv-#{Time.current}")
		#Zip::OutputStream.open(t.path) do |z|
			#ActiveRecord::Base.connection.tables.each do |table|
			#end # end table
			
		#end # end z
		dirname = "#{Rails.root}/tmp/csv"
		if !Dir.exists?(dirname) then Dir.mkdir(dirname) end
		tables = ActiveRecord::Base.connection.tables.reject { |table| ['schema_info', 'schema_migrations'].include?(table) }
		tables.each do |table|
			table_column_names = ActiveRecord::Base.connection.columns(table).map { |c| c.name }
			io = File.new("#{dirname}/#{table}.csv", "w+")
			io.write(table_column_names.to_csv)
			#total_count = ActiveRecord::Base.connection.select_one("SELECT COUNT(*) FROM #{SerializationHelper::Utils.quote_table(table)}").values.first.to_i
			#pages = (total_count.to_f / 1000).ceil - 1 # 1000 enregistrements par page
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
		redirect_to :back
  end
  
  def send_yaml_backup_file
    #send_file YAML_BACKUP_PATH, :type => 'application/zip', :disposition => 'attachment', :filename => CORM_YAML_FILE
		ENV['class'] = "YamlDb::Helper"
		format_class = ENV['class'] || "YamlDb::Helper"
		helper = format_class.constantize
		SerializationHelper::Base.new(helper).dump "#{Rails.root}/db/data.yml"
		redirect_to :back
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
  
  

  
end
