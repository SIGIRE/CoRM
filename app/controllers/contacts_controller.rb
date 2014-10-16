# encoding: utf-8

##
# This class manage Contacts and render all pages necessary for CRUD and for add/remove tags
# 
class ContactsController < ApplicationController
  load_and_authorize_resource

  has_scope :by_account_company_like
  has_scope :by_full_name_like
  has_scope :by_tel_like
  has_scope :active, type: :boolean, default: true
  has_scope :inactive, type: :boolean
  has_scope :by_account_id
  has_scope :by_tags
  has_scope :by_account_tags

  ##
  # Show the full list of Contact by paginate_by
  #
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = apply_scopes(Contact).
                order("surname")

    flash.now[:alert] = "Pas de contacts !" if @contacts.empty?

    respond_to do |format|
      format.html { @contacts = @contacts.page(params[:page]) }
      format.json { render :json => @contacts }
      format.csv { render :text => @contacts.to_csv }
    end
  end
  
  ##
  # Same as index, for extraction
  #
  # GET /contacts
  # GET /contacts.json
  def extract
    @contacts = apply_scopes(Contact).
                order("surname")

    flash.now[:alert] = "Pas de contacts !" if @contacts.empty?

    respond_to do |format|
      format.html { @contacts = @contacts.page(params[:page]) }
      format.json { render :json => @contacts }
      format.csv { render :text => @contacts.to_csv }
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
    @contact = Contact.new
    if (!params[:email].nil?)
      @contact.email = params[:email]
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact }
    end
  end

  ##
  # Show the filled form with the Contact you want to modify
  #
  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  ##
  # Create action for a Contact
  #
  # POST /contacts
  # POST /contacts.json
  def create
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
  end

  ##
  # Save a Contact which already exists
  #
  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
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
  end

  ##
  # Remove a Contact from the DataBase
  #
  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
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
