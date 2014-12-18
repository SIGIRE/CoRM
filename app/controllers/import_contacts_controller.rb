# encoding: utf-8

##
# Controller that manage Import_contact
#

class ImportContactsController < ApplicationController

  has_scope :anomaly
 
  # Show the full list of Accounts by paginate_by
  def index
    #variables for render
    @title=t('title.import_waiting')
    @link="new_link"
    @all_import_contacts=ImportContact.count

    @import_contacts = apply_scopes(ImportContact).order("anomaly DESC", "surname")
    
    #check for anomaly except when just rendering filter
    if params[:commit]!='Filtrer'
      ImportContact.transaction do    
        ImportContact.find_each do |i|
            ImportContact.checked_contact(i)
        end
      end
    end
    
    
    
    #to keep info filter
    if !params[:anomaly].nil?
        @select=params[:anomaly]
    end
    
    if @all_import_contacts==0 
      flash.now[:alert] = "#{t('app.message.alert.no_contact_pending_validation')}" 
    else
      nbr_anomaly=ImportContact.where('anomaly != ?', ImportContact::ANOMALIES[:no]).count
      if nbr_anomaly>0
        flash.now[:alert] = "#{t('app.message.alert.accounts_in_anomaly', nbr: nbr_anomaly)}"
      else
        flash.now[:notice] = "#{t('app.message.alert.accounts_in_anomaly', nbr: 'Aucun')}"
      end
      
        
    end
    
    respond_to do |format|
      format.html { @import_contacts = @import_contacts.page(params[:page]) }
      format.json { render :json => @import_contacts }
      #format.csv { render :text => @import_contacts.to_csv }
    end
    
    rescue Exception => e
            #if an exception occurs during checking import_contacts
            respond_to do |format|
               flash.now[:alert] = t('app.check_undefined_error')+" : "+e.message
               format.html { @import_contacts = @import_contacts.page(params[:page]) }
            end
    
  end
  
  ##
  # Render a page to edit one occurence of Import_contact
  #
  # GET /import_contacts/1/edit
  def edit 
    @contact = ImportContact.find(params[:id])
    @users = User.all_reals
    
    #variables for render
    @title=t('app.actions.edition').capitalize+" "+t('app.model.Contact')+" "+@contact.full_name
    @link="back_link"
    @select=params[:anomaly]
  end
  
  ##
  # Save an instance of Account which already exists
  #
  # PUT /import_contacts/1
  def update
    #if index is filter, keep it filter
    if !params[:anomaly].nil?
        select=params[:anomaly]
    end
    
    @import_contact = ImportContact.find(params[:id])
    @import_contact.modified_by = current_user.id
    @import_contact.update_attributes(params[:import_contact])
    
    respond_to do |format|
        format.html { redirect_to import_contacts_path(:anomaly=>select), :notice => "#{t('app.message.notice.updated_contact')}" }      
    end 
  end
  
  def importing_contacts
    total=0
    import_contacts=ImportContact.all
    import_contacts.each do |i|
      #if no anomaly in temporary contact or just warning on company name
      if i.anomaly==ImportContact::ANOMALIES[:no] || i.anomaly==ImportContact::ANOMALIES[:no_account]
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
            format.html { redirect_to import_contacts_path, :notice => "#{t('app.message.notice.confirm_import_contact', nbr: total)}"  }
    end
  end
  
  def destroy
        
    #if index is filter, keep it filter after delete account
    if !params[:anomaly].nil?
        select=params[:anomaly]
    end
    
    @import_contact = ImportContact.find(params[:id])
    @import_contact.destroy
    anomaly=@import_contact.anomaly
    
    #if is delete because is a duplicate account, check import_accounts before redirect
    #in order to change anomaly statut of the other account
  
    if anomaly==ImportContact::ANOMALIES[:duplicate]
        ImportContact.find_each(:conditions=>"anomaly = '#{ImportContact::ANOMALIES[:duplicate]}'") do |contact1|
            match=false
            ImportContact.find_each(:conditions=>"id != #{contact1.id}") do |contact2|
                if ImportContact::is_match(contact1,contact2)
                    match=true
                end
                break if match
            end
            if !match
                contact1.update_attributes(:anomaly => ImportContact::ANOMALIES[:no])
            end
        end
    end
    
    respond_to do |format|
        format.html { redirect_to import_contacts_path(:anomaly=>select), :notice => "#{t('app.message.notice.delete_contact')}"  }
    end
  end
  
  #this method scan all import_contacts and search duplicate
  def recalculate_duplicates
    nbr=0
    ImportContact.find_each do |contact1|
      ImportContact.find_each(start: (contact1.id)+1) do |contact2|
        if ImportContact.is_match(contact1,contact2)
          nbr+=1
          contact1.update_attributes(:anomaly=>ImportContact::ANOMALIES[:duplicate]) unless contact1.anomaly==ImportContact::ANOMALIES[:duplicate]
          contact2.update_attributes(:anomaly=>ImportContact::ANOMALIES[:duplicate]) unless contact2.anomaly==ImportContact::ANOMALIES[:duplicate]
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to import_contacts_path(:invalid=>"no"), :notice => "#{t('app.message.notice.recalculate_duplicates', nbr: nbr)}"}

    end
  end
  
end