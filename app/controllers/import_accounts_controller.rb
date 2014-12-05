# encoding: utf-8

##
# Controller that manage Import_account
#
class ImportAccountsController < ApplicationController

    has_scope :by_company_like, as: :company    

  # Show the full list of Accounts by paginate_by
  def index
      @title=t('title.import_waiting')
    @import_accounts = apply_scopes(ImportAccount).order("company")
    
    #check if import_accounts are correct
    if !@import_accounts.empty?
        checkAccount
    end
    
    flash.now[:alert] = "Pas de comptes en attente de validation !" if @import_accounts.empty?

    respond_to do |format|
      format.html { @import_accounts = @import_accounts.page(params[:page]) }
      format.json { render :json => @import_accounts }
      format.csv { render :text => @import_accounts.to_csv }
    end
  end
  
  #create accounts from import_accounts in database which have a true valid_account
  #this method is called from import button in index view
  def validate 
    @total=0
    import_accounts=ImportAccount.all
    import_accounts.each do |i|
        if i.valid_account
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
            @total+=1
            i.destroy
        end    
    end
    
    respond_to do |format|
            format.html { redirect_to import_accounts_path, :notice => "#{@total} comptes ont été importés !"  }
    end
  end
  
  private
  
  def checkAccount    
    @import_accounts.each do |i|
        if i.company.nil? || !i.company=~(/\w/) #if company is nil or empty
            i.update_attributes(:valid_account => false)
        end
        
    end  
  end
  
end