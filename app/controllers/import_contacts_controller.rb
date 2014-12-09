# encoding: utf-8

##
# Controller that manage Import_contact
#

class ImportContactsController < ApplicationController

  has_scope :invalid
 
  # Show the full list of Accounts by paginate_by
  def index
    @title=t('title.import_waiting')
    @import_contacts = apply_scopes(ImportContact).order("surname")
    
    flash.now[:alert] = "Pas de contacts en attente de validation" if @import_contacts.empty?

    respond_to do |format|
      format.html { @import_contacts = @import_contacts.page(params[:page]) }
      format.json { render :json => @import_contacts }
      #format.csv { render :text => @import_contacts.to_csv }
    end
  end
  
  ##
  # Render a page to edit one occurence of Import_contact
  #
  # GET /import_contacts/1/edit
  def edit
    @contact = ImportContact.find(params[:id])
    @users = User.all_reals
  end
  
  def update
    @import_contact = ImportContact.find(params[:id])
    @import_contact.modified_by = current_user.id
    @import_contact.update_attributes(params[:import_contact])
    
    ImportContact.checked_contact(@import_contact)
    
    respond_to do |format|
        format.html { redirect_to import_contacts_path, :notice => 'Le contact a été modifié.' }      
    end 
  end
  
  def validate_contacts
    total=0
    import_contacts=ImportContact.all
    import_contacts.each do |i|
      #if no anomaly in temporary contact
      if i.anomaly=='-'
          contact=Contact.new
          contact.surname=i.surname
          contact.forename=i.forename
          contact.title=i.title
          contact.tel=i.tel
          contact.fax=i.fax
          contact.mobile=i.mobile
          contact.email=i.email
          contact.job=i.job
          contact.notes=i.notes
          contact.created_by=i.created_by
          contact.modified_by=i.modified_by
          contact.account_id=i.account_id
          contact.active=i.active
          contact.import_id=i.import_id
          contact.created_at=i.created_at
          contact.updated_at=i.updated_at            
          contact.save!
          total+=1
          #delete temporary contact when save in DB
          i.destroy
      end
    end
    
    respond_to do |format|
            format.html { redirect_to import_contacts_path, :notice => "#{total} contacts ont été importés !"  }
    end
  end
  
  def destroy
        @import_contact = ImportContact.find(params[:id])
        @import_contact.destroy
        respond_to do |format|
            format.html { redirect_to import_contacts_path, :notice => "Le compte a bien été supprimé."  }
        end
    end
  
end