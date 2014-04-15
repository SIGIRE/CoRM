# encoding: utf-8

##
# Controller that manage Account
#
class AccountsController < ApplicationController
  
  before_filter :check_can_read!, only: [:show]

  ##
  # Show the full list of Accounts by paginate_by

  def index
    @accounts = Account.order("company").page(params[:page])
    
    #creation des ensembles contenant les comptes et contacts pour l'utilisation du typeahead
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company) #societe
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname) #nom

    flash.now[:alert] = "Pas de comptes !" if @accounts.empty?

    respond_to do |format|
      format.html
      format.json { render :json => @accounts }
    end
  end

  ##
  # Show events of an account

  def show
    @account = Account.find(params[:id])
    respond_to do |format|
      format.html { render :layout => 'account_show' }
      format.json { render :json => @account }
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
  	  @users = User.all_reals
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @account }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
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
	  @users = User.all_reals
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
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
      @account.web = self.to_url(@account.web)
      if params[:display_account_tag].nil?
        @account.tags.clear
      else
        tag = Tag.find(params[:display_account_tag])
        @account.tags.clear
        @account.tags << tag #unless @compte.produits.exists?(produit)
      end
  
      respond_to do |format|
        if @account.save
          format.html { redirect_to account_events_url(@account.id), :notice => 'Le compte a été créé.' }
          format.json { render :json => @account, :status => :created, :location => @account }
        else
          flash[:error] = t('app.save_undefined_error')
          format.html { render :action => "new" }
          format.json { render :json => @account.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
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
      params[:account][:company] = UnicodeUtils.upcase(params[:account][:company], I18n.locale)
      params[:account][:web] = self.to_url(params[:account][:web])
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
          flash[:error] = t('app.save_undefined_error')
          format.html { render :action => "edit" }
          format.json { render :json => @account.errors, :status => :unprocessable_entity }
        end
      end 
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
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
        format.html { redirect_to root_path, :notice => "Le compte a bien été supprimé."  }
        format.json { head :no_content }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
      return false
    end
  end
  
  ##
  # Called by the main search bar
  # search?account=[xxx]
  #
  def search
    if !params.nil? and !params[:account].nil?
      company = UnicodeUtils.upcase(params[:account].strip.concat("%"))
      if params[:format] and params[:format] != 'html' then
        @elements = Array.new
        # You can put the contact url edit pattern here, to redirect when a conctact will be selected in typeahead
        @elements.push({ :type => 'info', 'account_url' => '/compte/[:id]/evenements', 'contact_url' => '/compte/[:account_id]/evenements', 'contact_url_default' => '/contact/[:id]/edit' })
        Account.where('company LIKE ? OR company LIKE ?', company, '%'.concat(company)).select('id, company AS name').each {|e|
          @elements.push({ :id => e.id, :name => e.name, :type => 'account' }) 
        }
        if (!params[:contacts].nil? and params[:contacts] == 'true')
          Contact.where('surname LIKE ? OR forename LIKE ?', company, company).select('id, title, forename, surname, account_id').limit(10).each {|e|
            @elements.push({ :id => e.id, :name => e.full_name, :account_id => e.account_id, :type => 'contact' })
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
    if params[:filter].values.all? { |element| element.blank? }
      @accounts = Account.order('accounts.company ASC')
                         .page(params[:page])
    else
      # Filter params
      @company_filter = params[:filter][:company]
      @contact_full_name_filter = params[:filter][:contact]
      @tel_filter = params[:filter][:tel]

      # Query
      accounts_by_company = @company_filter.blank? ? Account.none : Account.by_company_like(@company_filter)
      accounts_by_contact_full_name = @contact_full_name_filter.blank? ? Account.none : Account.by_contact_full_name_like(@contact_full_name_filter)
      accounts_by_tel = @tel_filter.blank? ? Account.none : Account.by_tel(@tel_filter)

      # Combining results with | returns an array, not an ActiveRecord result !
      accounts = accounts_by_company | accounts_by_contact_full_name | accounts_by_tel
      # Kaminari wrapper for arrays
      @accounts = Kaminari::paginate_array(accounts).page(params[:page])
    end

    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @accounts }
    end
  end
  
  ##
  # Add a Tag to an Account
  #
  def add_tag
    if @ability.can? :update, Account
      @tag = Tag.find(params[:tag_id])
      @account = Account.find(params[:account_id])
      @account.tags << @tag
      redirect_to account_tags_url(@account.id), :notice => "Affectation du tag effectuée."
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
      return false
    end
  end
  
  ##
  # Remove a Tag from an Account
  #
  def delete_tag
    if @ability.can? :update, Account
      @tag = Tag.find(params[:tag_id])
      @account = Account.find(params[:account_id])
      @account.tags.delete(@tag)
  
      respond_to do |format|
          format.html  { redirect_to account_tags_url(@account.id), :notice => "Suppression de l'affectation du tag effectuée." }
          format.json  { render :json => @tag }
      end
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
      return false
    end
  end
  
  def to_url(url)
    if !url.nil? and url.length > 0
      correction = nil
      # dont start with protocol://
      if url[/^*:\/\//] == nil
        correction = 'http://'
        # if it is somthing like lang.website.tld
        if url[/^www[.]/] == nil and url[/^.*.[.].*.[.].*.$/] == nil
          correction.concat('www.')
        end
      end
    end
    return (!correction.nil?() ? correction.concat(url) : url)
  end

  private
  def check_can_read!
    unless @ability.can? :read, Account
      flash[:error] = t('app.cancan.messages.unauthorized').
        gsub('[action]', t('app.actions.show')).
        gsub('[undefined_article]', t('app.default.undefine_article_male')).
        gsub('[model]', t('app.controllers.Account'))
      redirect_to accounts_url
      return false
    end
  end
  
end
