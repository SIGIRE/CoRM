# encoding: utf-8

##
# Controller that manage Import_account
#
class ImportAccountsController < ApplicationController

    has_scope :invalid

  
  # Show the full list of Accounts by paginate_by
  def index
    #variables for render
    @title=t('title.import_waiting')
    @link="new_link"
    
    @import_accounts = apply_scopes(ImportAccount).order("company")
    
    flash.now[:alert] = "#{t('app.message.alert.no_account_pending_validation')}" if @import_accounts.empty?

    respond_to do |format|
      format.html { @import_accounts = @import_accounts.page(params[:page]) }
      format.json { render :json => @import_accounts }
      #format.csv { render :text => @import_accounts.to_csv }
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
    @title=t('app.actions.edition').capitalize+" "+t('app.model.Account')+" "+@import_account.company
    @link="back_link"
  end
  
  ##
  # Save an instance of Account which already exists
  #
  # PUT /import_accounts/1
  def update
    @import_account = ImportAccount.find(params[:id])
    @import_account.modified_by = current_user.id
    params[:import_account][:company] = UnicodeUtils.upcase(params[:import_account][:company], I18n.locale)
    params[:import_account][:web] = Format.to_url(params[:import_account][:web])
    @import_account.update_attributes(params[:import_account])
    
    ImportAccount.checked_account(@import_account)
    
    respond_to do |format|
        format.html { redirect_to import_accounts_path, :notice => "#{t('app.message.notice.updated_account')}" }
      
    end 
  end
  
  #create accounts from import_accounts in database which have a true valid_account
  #this method is called from import button in index view
  def validate_accounts
    total=0
    import_accounts=ImportAccount.all
    import_accounts.each do |i|
        #if no anomaly in temporary account
        if i.anomaly=='-'
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
            #delete temporary contact when save in DB
            i.destroy
        end    
    end
    
    respond_to do |format|
            format.html { redirect_to import_accounts_path, :notice => "#{t('app.message.notice.confirm_import_account', nbr: total)}"  }
    end
  end
  
  def destroy
        @import_account = ImportAccount.find(params[:id])
        @import_account.destroy
        respond_to do |format|
            format.html { redirect_to import_accounts_path, :notice => "#{t('app.message.notice.delete_account')}" }
        end
    end

  
  
end