# encoding: utf-8

##
# Controller that manage Account
#
class AccountsController < ApplicationController
  
  ##
  # Show the full list of Accounts by paginate_by
  #
  # GET /accounts
  # GET /accounts.json
  def index
    
    @accounts = Account.order("company").page(params[:page])
    
    #creation des ensembles contenant les comptes et contacts pour l'utilisation du typeahead
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company) #societe
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname) #nom

    respond_to do |format|
      format.html
      format.json { render :json => @accounts }
    end
  end

  ##
  # Show one occurence of Account
  #
  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if @ability.can? :read, Account
      @account = Account.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @account }
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end

  ##
  # Render a page with a form to create a new Account
  #
  # GET /accounts/new
  # GET /accounts/new.json
  def new
    if @ability.can? :create, Account
      @account = Account.new
      @account.user = current_user
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @account }
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end

  ##
  # Render a page to edit one occurence of Account
  #
  # GET /accounts/1/edit
  def edit
    if @ability.can? :update, Account
      @account = Account.find(params[:id])
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end

  ##
  # Save an instance of Account to the DB
  #
  # POST /accounts
  # POST /accounts.json
  def create
    if @ability.can? :create, Account
      @account = Account.new(params[:account])
      @account.created_by = current_user.id
      @account.company = @account.uppercase_company
      
      if params[:display_account_tag].nil?
        @account.tags.clear
      else
        tag = Tag.find(params[:display_account_tag])
        @account.tags.clear
        @account.tags << tag #unless @compte.produits.exists?(produit)
      end
  
      respond_to do |format|
        if @account.save
          format.html { redirect_to accounts_path, :notice => 'Le compte a été créé.' }
          format.json { render :json => @account, :status => :created, :location => @account }
        else
          format.html { render :action => "new" }
          format.json { render :json => @account.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end

  ##
  # Save an instance of Account which already exists
  #
  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    if @ability.can? :update, Account
      @account = Account.find(params[:id])
      @account.modified_by = current_user.id
      @account.company = @account.uppercase_company
      if params[:display_account_tag].nil?
        @account.tags.clear
      else
        tag = Tag.find(params[:display_account_tag])
        @account.tags.clear
        @account.tags << tag
      end
      
      respond_to do |format|
        if @account.update_attributes(params[:account])
          format.html { redirect_to account_events_url(@account.id), :notice => 'Le compte a été mis à jour.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @account.errors, :status => :unprocessable_entity }
        end
      end 
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end

  ##
  # Delete an Account stored into the DB
  #
  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    if @ability.can? :destroy, Account
      @account = Account.find(params[:id])
      @account.destroy
  
      respond_to do |format|
        format.html { redirect_to accounts_url }
        format.json { head :no_content }
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end
  
  ##
  # Called by the main search bar
  # search?account=[xxx] [&as=json]
  #
  def search
    if !params.nil? and !params[:account].nil?
      company = UnicodeUtils.upcase("%#{params[:account].strip}%")
      if params[:format] and params[:format] != 'html' then
        @elements = Array.new
        @elements.push({ :type => 'info', 'account_url' => '/compte/[:id]/evenements', 'contact_url' => '/contact/[:id]/edit' })
        Account.where('company LIKE ?', company).select('id, company AS name').limit(10).each {|e|
          @elements.push({ :id => e.id, :name => e.name, :type => 'account' }) 
        }
        if (!params[:contacts].nil? and params[:contacts] == 'true')
          Contact.where('surname LIKE ? OR forename LIKE ?', company, company).select('id, title, forename, surname').limit(10).each {|e|
            @elements.push({ :id => e.id, :name => e.full_name, :type => 'contact' })
          } 
        end
        @response = @elements
      else
        @accounts = Account.where('company LIKE ?', company).page(params[:page]).per(25)
      end
      respond_to do |format|
        format.html { render :action => :index }
        format.json { render :json => @elements }
      end
    end
  end
  
  ##
  # Filter Account on the index page
  #
  def filter

    #necessaire pour que le typeahead soit utilisable après un filtrage
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company)
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname)

    #données du filtre
    company = params[:filter][:company]
    if company.blank?
      company = nil
    end
    contact_surname = params[:filter][:contact]
    tel = params[:filter][:tel]
    
    # Contact without surname
    if contact_surname != ""
      # Get the contact with surname == params[:filter][:surname]
      contact = Contact.find(:first, :conditions => ['surname LIKE ?', contact_surname])
    end
    
    @accounts = Account.by_company(company).by_contact(contact).by_tel(tel)
    @accounts = @accounts.order("company ASC").page(params[:page])
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @accounts }
    end
  end
  
  ##
  # Add a Tag to an Account
  #
  def add_tag
    if @ability.can? update, Account
      @tag = Tag.find(params[:tag_id])
      @account = Account.find(params[:account_id])
      @account.tags  << @tag
      respond_to do |format|
          format.html  { redirect_to account_events_url(@account.id), :notice => "Affectation du Tag effectuée!" }
          format.json  { render :json => @tag }
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end
  
  ##
  # Remove a Tag from an Account
  #
  def delete_tag
    if @ability.can? update, Account
      @tag = Tag.find(params[:tag_id])
      @account = Account.find(params[:account_id])
      @account.tags.delete(@tag)
  
      respond_to do |format|
          format.html  { redirect_to account_events_url(@account.id), :notice => "Suppression de l'affectation du Tag effectuée!" }
          format.json  { render :json => @tag }
      end
    else
      redirect_to accounts_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      return false
    end
  end
  
  
end
