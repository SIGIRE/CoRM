# encoding: utf-8

##
# This class manage Contacts and render all pages necessary for CRUD and for add/remove tags
# 
class ContactsController < ApplicationController
  
  ##
  # Show the full list of Contact by paginate_by
  #
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.order("surname").page(params[:page])
    
    #infos typeahead
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company)
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
    end
  end

  ##
  # Show one occurence of Contact
  #
  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact }
    end
  end

  ##
  # Show the form to create a new Contact
  #
  # GET /contacts/new
  # GET /contacts/new.json
  def new
    if @ability.can? :create, Contact
      @contact = Contact.new
      if (!params[:email].nil?)
				@contact.email = params[:email]
      end
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @contact }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Contact'))
      redirect_to contacts_url
      return false
    end
  end

  ##
  # Show the filled form with the Contact you want to modify
  #
  # GET /contacts/1/edit
  def edit
    if @ability.can? :update, Contact
      @contact = Contact.find(params[:id])
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Contact'))
      redirect_to contacts_url
      return false
    end
  end

  ##
  # Create action for a Contact
  #
  # POST /contacts
  # POST /contacts.json
  def create
    if @ability.can? :create, Contact
      @contact = Contact.new(params[:contact])
      @contact.created_by = current_user.id
  		
      # Manage the has_and_belongs relation between Accounts and Tags
      # if there is no one associate tag, we delete links
      if params[:display_contact_produit].nil?
        @contact.tags.clear
      else
        tag = Tag.find(params[:display_contact_tag])
        @contact.tags.clear
        @contact.tags << tag
      end
          
      respond_to do |format|
        if @contact.save
		    update_emails(@contact)

          format.html {
            if  (@contact.account).nil?  then redirect_to contacts_path, :notice => 'Le contact a été créé.'
            else redirect_to account_events_url(@contact.account_id), :notice => 'Le contact a été créé.'
            end
          }
          o = {
            :contact => @contact,
            :paths => {
            :edit => edit_contact_url(@contact.id)
            }
          }
          format.json { render :json => o, :status => :created, :location => @contact }
        else
          flash[:error] = t('app.save_undefined_error')
          format.html { render :action => "new" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Contact'))
      redirect_to contacts_url
      return false
    end
  end

  ##
  # Save a Contact which already exists
  #
  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    if @ability.can? :update, Contact
      @contact = Contact.find(params[:id])
      @contact.modified_by = current_user.id
      
      # same treatment as #create
      if params[:display_contact_tag].nil?
        @contact.tags.clear
      else
        tag = Tag.find(params[:display_contact_tag])
        @contact.tags.clear
        @contact.tags << tag
      end
      respond_to do |format|
        if @contact.update_attributes(params[:contact])
		    update_emails(@contact)
            format.html {
                if  (@contact.account).nil?  then redirect_to contacts_path, :notice => 'Le contact a été mis à jour.'
                else redirect_to account_events_url(@contact.account_id), :notice => 'Le contact a été mis à jour.'
                end }
          format.json { head :no_content }
        else
          flash[:error] = t('app.save_undefined_error')
          format.html { render :action => "edit" }
          format.json { render :json => @contact.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Contact'))
      redirect_to contacts_url
      return false
    end
  end

  ##
  # Remove a Contact from the DataBase
  #
  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    if @ability.can? :destroy, Contact
      @contact = Contact.find(params[:id])
			
			Email.where(:contact_id => @contact.id).each do |email|
				email.contact_id = nil
				email.save
			end 
      @contact.destroy
  
      respond_to do |format|
        format.html { redirect_to (@contact.account.nil?() ? root_path : account_events_path(@contact.account)), :notice => "Le contact a bien été supprimé."  }
        format.json { head :no_content }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Contact'))
      redirect_to contacts_url
      return false
    end
  end
  
  ##
  # Filter Contact on the index page
  #
  def filter
    if params[:filter].values.all? { |element| element.blank? }
      @contacts = Contact.order('contacts.forename ASC')
                         .page(params[:page])
    else
      # Filter params
      @company_filter = params[:filter][:company]
      @full_name_filter = params[:filter][:full_name]
      @tel_filter = params[:filter][:tel]

      # Query
      contacts_by_company = @company_filter.blank? ? Contact.none : Contact.by_company_like(@company_filter)
      contacts_by_full_name = @full_name_filter.blank? ? Contact.none : Contact.by_full_name_like(@full_name_filter)
      contacts_by_tel = @tel_filter.blank? ? Contact.none : Contact.by_tel(@tel_filter)

      # Combining results with | returns an array, not an ActiveRecord result !
      contacts = contacts_by_company | contacts_by_full_name | contacts_by_tel
      # Kaminari wrapper for arrays
      @contacts = Kaminari::paginate_array(contacts).page(params[:page])
    end

    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @contacts }
    end
  end

  def update_emails(contact)
    puts "UPDATE EMAILS!"
    if (Contact.where(:email => @contact.email).length == 1)
		if (!contact.email.blank?)
			adresse = contact.email
			account = contact.account_id
			emails = Email.where(:to => adresse, :contact_id => nil)
			
			emails.each do |email|
				email.contact_id = contact.id
				email.save
			end
		end
    end
  end
	
  
end
