##
# Class that manage data extraction from the DataBase to CSV
#
class ExtractionsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /extractions/select_param_accounts
  def select_param_accounts
		if current_user.has_role?(:super_user) || current_user.has_role?(:admin)
		
		# tags
		@tags = Tag.all
		
		# origins
		@origins = Origin.all
		
		# users
		@users = User.all

		# categories
		@categories = Account::CATEGORIES

				
		else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Extraction'))
			redirect_to root_url
			return false
		end
  end

  # GET /extractions/select_param_contacts
  def select_param_contacts
		if current_user.has_role?(:super_user) || current_user.has_role?(:admin)

		# accounts
		@accounts = Account.all
		
		# tags
		@tags = Tag.all
		
		# origins
		@origins = Origin.all

		# categories
		@categories = Account::CATEGORIES		
		
		# users
		@users = User.all
		
		else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Extraction'))
			redirect_to root_url
			return false
		end
	end


  ##
  # Extracting data for Accounts
  #
  def accounts
	
	require 'csv'
    require 'iconv'

	
	# Select via checkbox tags 
	tags=params[:tags] || Array.new
	tags_ids=Array.new
	tags.each do |key, tag|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			tags_ids.push(id)
		end
	end
	
	# Select via checkbox origins 
	origins=params[:origins] || Array.new
	origins_ids=Array.new
	origins.each do |key, origin|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			origins_ids.push(id)
		end
	end	

	# Select via checkbox users 
	users=params[:users] || Array.new
	users_ids=Array.new
	users.each do |key, user|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			users_ids.push(id)
		end
	end

	# Select via checkbox categories 
	categories=params[:categories] || Array.new
	categories_ids=Array.new
	categories.each do |key, category|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			categories_ids.push(Account::CATEGORIES[id.to_i])
		end
	end	
    
    @accounts = Account.by_zip(params[:zip]).by_country(params[:country]).by_tags(tags_ids).by_user(users_ids).by_category(categories_ids).by_origin(origins_ids)

    accounts_csv = CSV.generate(:col_sep => ';') do |csv|
      # header row
      csv << ['id', 'company', 'adress1', 'adress2', 'ZIP code', 'City', 'Country', 'Telephone', 'Fax', 'E-Mail', 'Website', 'Accounting Code', 'Category', 'collaborator', 'origin']
      # data row
      @accounts.each do |account|
        csv << [
		account.id, 
		account.company, 
		account.adress1, 
		account.adress2, 
		account.zip, 
		account.city, 
		account.country, 
		account.tel,
		account.fax, 
		account.email, 
		account.web, 
		account.accounting_code, 
		account.category, 
		(account.user.full_name unless account.user.nil?), 
		(account.origin.name unless account.origin.nil?) 
	]
      end
    end

    send_data(accounts_csv, :type => 'text/csv; charset=utf-8; header=present', :filename => "#{Time.now.strftime("%d-%m-%Y_%Hh%M")}_accounts.csv") 
  end

  ##
  # Extracting data for Contacts & Accounts
  #
  def contacts
    require 'csv'
    require 'iconv'

	# Select via checkbox accounts 
	accounts=params[:accounts] || Array.new
	accounts_ids=Array.new
	accounts.each do |key, account|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			accounts_ids.push(id)
		end
	end
	
	# Select via checkbox tags 
	tags=params[:tags] || Array.new
	tags_ids=Array.new
	tags.each do |key, tag|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			tags_ids.push(id)
		end
	end	
	
	# Select via checkbox origins 
	origins=params[:origins] || Array.new
	origins_ids=Array.new
	origins.each do |key, origin|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			origins_ids.push(id)
		end
	end	

	# Select via checkbox categories 
	categories=params[:categories] || Array.new
	categories_ids=Array.new
	categories.each do |key, category|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			categories_ids.push(Account::CATEGORIES[id.to_i])
		end
	end
	
	# Select via checkbox users 
	users=params[:users] || Array.new
	users_ids=Array.new
	users.each do |key, user|
		k= key.split('_')
		if (k.length == 2)
			id = k[1]
			users_ids.push(id)
		end
	end
    
    @contacts = Contact.by_accounts(accounts_ids).by_zip_account(params[:zip]).by_country_account(params[:country]).by_tags(tags_ids).by_user_account(users_ids).by_category_account(categories_ids).by_origin_account(origins_ids)

    contacts_csv = CSV.generate(:col_sep => ';') do |csv|
      # header row
      csv << ['id', 'Surname', 'Forename', 'Title', 'Telephone', 'Fax', 'E-Mail', 'Mobile', 'Fonction', 'Company', 'Adress1', 'Adress2', 'ZIP', 'City', 'Country', 'Telephone', 'Fax', 'E-Mail', 'Category', 'Collaborator', 'Origin']
      # data row
      @contacts.each do |contact|
        csv << [
		contact.id, 
		contact.surname, 
		contact.forename, 
		contact.title,
		contact.tel, 
		contact.fax, 
		contact.email,
		contact.mobile,
		contact.job,
		(contact.account.company unless contact.account.nil?), 
		(contact.account.adress1 unless contact.account.nil?),
		(contact.account.adress2 unless contact.account.nil?), 
		(contact.account.zip unless contact.account.nil?), 
		(contact.account.city unless contact.account.nil?), 
		(contact.account.country unless contact.account.nil?), 
		(contact.account.tel unless contact.account.nil?), 
		(contact.account.fax unless contact.account.nil?), 
		(contact.account.email unless contact.account.nil?), 
		(contact.account.category unless contact.account.nil?), 
		(contact.account.user.full_name unless (contact.account.nil? or contact.account.user.nil?)), 
		(contact.account.origin.name unless (contact.account.nil? or contact.account.origin.nil?))
	]
      end
    end

    send_data(contacts_csv, :type => 'text/csv; charset=utf-8; header=present', :filename => "#{Time.now.strftime("%d-%m-%Y_%Hh%M")}_contacts.csv")   
  end
  
  
end
