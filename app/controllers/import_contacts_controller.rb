# encoding: utf-8

##
# Controller that manage Import_contact
#

class ImportContactsController < ApplicationController

  has_scope :anomaly
 
  # Show the full list of Accounts by paginate_by
  def index
    #variables for render
    @title=t('title.import_contacts_waiting')
    @link="new_link"
    @all_import_contacts=ImportContact.count
    
    #these two lines are for filter with anomalies that exists in the index of import_contacts
    by_anomalies = ImportContact.select(:anomaly_id).uniq
    @anomalies_filter = Anomaly.where(id: by_anomalies)

    @import_contacts = apply_scopes(ImportContact).joins(:anomaly).order("level DESC", "surname")
    #@import_contacts = apply_scopes(ImportContact).joins(:anomaly).joins('LEFT OUTER JOIN contacts ON contacts.id = import_contacts.id').order("level DESC", "surname")
    
    #to keep info filter
    if !params[:anomaly].nil? 
        @select=params[:anomaly]
    end
    
    if @all_import_contacts==0 
      flash.now[:alert] = "#{t('app.message.alert.no_contact_pending_validation')}" 
    else
      nbr_anomaly=ImportContact.joins(:anomaly).where('name != ?', 'ok').count
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
    
    #check
    @import_contact.check
    
    #for each import_contact with duplicate_import_anomaly
    ImportContact.where(anomaly_id: ImportContact::DUPLICATE_IMPORT_ANOMALY).find_each do |i|
        #reset anomaly_id
        i.update_attributes(:anomaly_id=>ImportContact::NO_ANOMALY)
        #check for anomaly
        i.check
    end
    
    respond_to do |format|
        format.html { redirect_to import_contacts_path(:anomaly=>select), :notice => "#{t('app.message.notice.updated_contact')}" }      
    end 
  end
  
  def importing_contacts
    total=0
    #import_contacts=ImportContact.joins(:anomaly)
    ImportContact.find_each do |i|
      #if no anomaly in temporary contact or just warning on company name
      if i.anomaly.level!=3 && (can? :manage, ImportContact)
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
    
    #for each import_contact with duplicate_import_anomaly
    ImportContact.where(anomaly_id: ImportContact::DUPLICATE_IMPORT_ANOMALY).find_each do |i|
        #reset anomaly_id
        i.update_attributes(:anomaly_id=>ImportContact::NO_ANOMALY)
        #check for anomaly
        i.check
    end
    
    respond_to do |format|
        format.html { redirect_to import_contacts_path(:anomaly=>select), :notice => "#{t('app.message.notice.delete_contact')}"  }
    end
  end
  
  def destroy_all_invalids
    
    # test user ability to prevent from accessing method from URL (see routes file)
    if can? :manage, ImportContact
      import_contacts = ImportContact.joins(:anomaly).where(anomalies: {level: 3})
      import_contacts.each do |i|
        i.destroy
      end
    end

    respond_to do |format|
        format.html { redirect_to import_contacts_path }
    end
  end
  
  #this method reset duplicates anomalies and re-scan all import_contacts for searching duplicates
  #and redirect to index import_contacts
  #call by clic on recalculate button in index
  def recalculate_duplicates
    
    nbr=0
    
    #set duplicate_import to no_anomaly
    duplicates_contacts = ImportContact.where(anomaly_id: [ImportContact::DUPLICATE_IMPORT_ANOMALY.id, ImportContact::DUPLICATE_DB_ANOMALY.id])
    duplicates_contacts.each do |d|
      d.update_attributes(:anomaly_id=>ImportContact::NO_ANOMALY.id)
    end
        
    ImportContact.find_each(:conditions => "no_search_duplicates=FALSE") do |contact1|      
      #search in import_contacts
      ImportContact.find_each(:conditions => "no_search_duplicates=FALSE", start: (contact1.id)+1) do |contact2|
        if ImportContact.is_match(contact1,contact2)
          nbr+=1
          contact1.update_attributes(:anomaly_id=>ImportContact::DUPLICATE_IMPORT_ANOMALY.id) unless contact1.anomaly_id==ImportContact::DUPLICATE_IMPORT_ANOMALY.id
          contact2.update_attributes(:anomaly_id=>ImportContact::DUPLICATE_IMPORT_ANOMALY.id) unless contact2.anomaly_id==ImportContact::DUPLICATE_IMPORT_ANOMALY.id
        end
      end
      
      #search in db
      Contact.find_each do |contact2|            
          if ImportContact.is_match(contact1, contact2)
            nbr+=1
            contact1.update_attributes(:anomaly_id => ImportContact::DUPLICATE_DB_ANOMALY.id)
            contact1.update_attributes(:contact_id=>contact2.id)
          end               
      end      
    end
    
    respond_to do |format|
      format.html { redirect_to import_contacts_path, :notice => "#{t('app.message.notice.recalculate_duplicates', nbr: nbr)}"}

    end
  end
  
end