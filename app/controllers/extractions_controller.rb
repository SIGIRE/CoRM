##
# Class that manage data extraction from the DataBase to CSV
#
class ExtractionsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /extractions/select_param_accounts
  def select_param_accounts
	if !current_user.has_role? :super_user
	  redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Extraction'))
	  return false
	end
  end

  # GET /extractions/select_param_contacts
  def select_param_contacts
	if !current_user.has_role? :super_user
	  redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Extraction'))
	  return false
	end
  end


  ##
  # Extracting data for Accounts
  #
  def accounts
	
    require 'csv'
    require 'iconv'
    
    @accounts = Account.by_zip(params[:zip]).by_country(params[:country]).by_tags(params[:tag]).by_user(params[:user]).by_category(params[:categories]).by_origin(params[:origins])

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

    send_data(accounts_csv, :type => 'text/csv; charset=utf-8; header=present', :filename => 'accounts.csv') 
  end

  ##
  # Extracting data for Contacts & Accounts
  #
  def contacts
    require 'csv'
    require 'iconv'
    
    @contacts = Contact.by_accounts(params[:account]).by_zip_account(params[:code_postal]).by_country_account(params[:pays]).by_tags(params[:produits]).by_user_account(params[:user]).by_category_account(params[:genres]).by_origin_account(params[:origines])

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

    send_data(contacts_csv, :type => 'text/csv; charset=utf-8; header=present', :filename => 'contacts.csv')   
  end
  
  
end
