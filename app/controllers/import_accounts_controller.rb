# encoding: utf-8

##
# Controller that manage Import_account
#
class ImportAccountsController < ApplicationController
    
    has_scope :anomaly

  
  # Show the full list of Import_accounts by paginate_by
  def index
 
    #variables for render
    @title=t('title.import_accounts_waiting')
    @link="new_link"
    @all_import_accounts=ImportAccount.count
    
    @import_accounts = apply_scopes(ImportAccount).order("anomaly DESC", "company")    
 
    #to keep info filter
    if !params[:anomaly].nil?
        @select=params[:anomaly]
    end
    
    if @all_import_accounts==0
        flash.now[:alert] = "#{t('app.message.alert.no_account_pending_validation')}" 
    else
        nbr_anomaly=ImportAccount.where('anomaly != ?', ImportAccount::ANOMALIES[:no]).count
        if nbr_anomaly==0
            flash.now[:notice] = "#{t('app.message.alert.accounts_in_anomaly', nbr: 0)}"
        else
            flash.now[:alert] = "#{t('app.message.alert.accounts_in_anomaly', nbr: nbr_anomaly)}"
        end   
    end

    respond_to do |format|
      format.html { @import_accounts = @import_accounts.page(params[:page]) }
      format.json { render :json => @import_accounts }
    end
    
  end
  
  ##
  # Render a page to edit one occurence of Import_account
  #
  # GET /import_accounts/1/edit
  def edit
    @import_account = ImportAccount.find(params[:id])
    @users = User.all_reals
    
    #variables for render
    company_name = '-'
    if !@import_account.company.nil?
        company_name = @import_account.company
    end        
    @title=t('app.actions.edition').capitalize+" "+t('app.model.Account')+" "+company_name
    @link="back_link"
    @select=params[:anomaly]   
  end
  
  ##
  # Save an instance of Account which already exists
  #
  # PUT /import_accounts/1
  def update
    #if index is filter, keep it filter
    if !params[:anomaly].nil?
        select=params[:anomaly]
    end
            
    @import_account = ImportAccount.find(params[:id])
    @import_account.modified_by = current_user.id
    params[:import_account][:company] = UnicodeUtils.upcase(params[:import_account][:company], I18n.locale)
    params[:import_account][:web] = Format.to_url(params[:import_account][:web])
    @import_account.update_attributes(params[:import_account])
    
    #check after update
    @import_account.check
    
    respond_to do |format|
        format.html { redirect_to import_accounts_path(:anomaly=>select), :notice => "#{t('app.message.notice.updated_account')}" }
      
    end 
  end
  
  #create accounts from import_accounts in database which have a true valid_account
  #this method is called from import button in index view
  def importing_accounts
    total=0
    import_accounts=ImportAccount.all
    import_accounts.each do |i|
        #if no anomaly in temporary account
        if i.anomaly==ImportAccount::ANOMALIES[:no]
            account=Account.new
            account.company=i.company
            account.adress1=i.adress1
            account.adress2=i.adress2
            account.zip=i.zip
            account.country=i.country
            account.accounting_code=i.accounting_code
            account.notes=i.notes
            account.created_by=i.created_by
            account.modified_by=i.modified_by
            account.created_at=i.created_at
            account.updated_at=i.updated_at
            account.user_id=i.user_id
            account.category=i.category
            account.tel=i.tel
            account.fax=i.fax
            account.email=i.email
            account.web=i.web
            account.origin_id=i.origin_id
            account.active=i.active
            account.import_id=i.import_id
            account.save!
            total+=1
            #delete temporary account when save in DB
            i.destroy
        end    
    end
    
    respond_to do |format|
            format.html { redirect_to import_accounts_path, :notice => "#{t('app.message.notice.confirm_import_account', nbr: total)}"  }
    end
  end
  
    def destroy
        #if index is filter, keep it filter after delete account
        if !params[:anomaly].nil?
            select=params[:anomaly]
        end

        
        @import_account = ImportAccount.find(params[:id])
        anomaly=@import_account.anomaly
        @import_account.destroy
        
        #if is delete because is a duplicate account, match import_accounts for duplicates before redirect
        #in order to change anomaly statut of the other account        
        if anomaly==ImportAccount::ANOMALIES[:duplicate]
            ImportAccount.find_each(:conditions=>"anomaly = '#{ImportAccount::ANOMALIES[:duplicate]}' AND company!=''") do |account1|
                match=false
                ImportAccount.find_each(:conditions=>"id != #{account1.id} AND company!=''") do |account2|
                    if ImportAccount::is_match(account1,account2)
                        match=true
                    end
                    break if match
                end
                if !match
                    account1.update_attributes(:anomaly => ImportAccount::ANOMALIES[:no])
                end
            end
        end
        
        respond_to do |format|
            format.html { redirect_to import_accounts_path(:anomaly=>select), :notice => "#{t('app.message.notice.delete_account')}" }
        end
    end
    
    #this method scan all import_accounts and search duplicate
    def recalculate_duplicates
        nbr=0
        ImportAccount.find_each(:conditions=>"company!=''") do |account1|
            ImportAccount.find_each(:conditions=>"company!=''", start: (account1.id)+1) do |account2|
                if ImportAccount.is_match(account1,account2)
                    nbr+=1
                    account1.update_attributes(:anomaly=>ImportAccount::ANOMALIES[:duplicate]) unless account1.anomaly==ImportAccount::ANOMALIES[:duplicate]
                    account2.update_attributes(:anomaly=>ImportAccount::ANOMALIES[:duplicate]) unless account2.anomaly==ImportAccount::ANOMALIES[:duplicate]
                end
            end
        end
        respond_to do |format|
            format.html { redirect_to import_accounts_path, :notice => "#{t('app.message.notice.recalculate_duplicates', nbr: nbr)}"}

        end
    end
 
end