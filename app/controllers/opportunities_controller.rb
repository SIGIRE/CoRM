# encoding: utf-8

class OpportunitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_account, only: [:index]
  layout :current_layout

  has_scope :by_user_id
  has_scope :by_statut
  has_scope :by_account_company_like
  has_scope :by_contact_id
  
  ##
  # Display the full list of Opportunities by paginate_by
  #
  def index
    @opportunities = apply_scopes(opportunities).
                     order('term desc').
                     page(params[:page])
    
    #initialisation puis calcul des totaux
    @total_amount = 0
    @total_profit = 0
    @opportunities.each do |op|
      @total_amount += op.amount
      @total_profit += op.profit
    end
          
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @opportunities, :locals =>{:total_amount => @total_amount , :total_profit => @total_profit }  }
    end
  end
  
  ##
  # Display one occurence of Opportunity
  #
  def show
    if @ability.cannot? :read, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    @opportunity = Opportunity.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @opportunity }
    end
  end
    
  ##
  # Redner the page to create a new Opportunity
  #
  def new
    if @ability.cannot? :create, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    @opportunity = Opportunity.new
    @opportunity.user = current_user
    @opportunity.account_id = params[:account_id]
    @users = User.all_reals
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @opportunity }
    end
  end
  
  ##
  # Process to save a new Opportunity
  #
  def create
    if @ability.cannot? :create, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    params[:opportunity][:profit] = params[:opportunity][:profit].gsub(' ', '')
    params[:opportunity][:amount] = params[:opportunity][:amount].gsub(' ', '')
    @opportunity = Opportunity.new(params[:opportunity])
    @opportunity.created_by = current_user.id
    if @opportunity.amount.nil?
      @opportunity.amount = 0
    end
    if @opportunity.profit.nil?
      @opportunity.profit = 0
    end
    respond_to do |format|
      if @opportunity.save
        if params[:mail] == 'yes'
          UserMailer.mail_for(@opportunity.user, @opportunity, true).deliver
        end
        if !@opportunity.account_id.nil?
          format.html  { redirect_to account_events_url(@opportunity.account_id), :notice => "L'opportunité a été créée." }
        else
          format.html  { redirect_to root_url(@opportunity.account_id), :notice => "L'opportunité a été créée." }
        end
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "new" }
      end
    end
  end
  
  ##
  # Render the page to edit an Opportunity
  #
  def edit
    if @ability.cannot? :update, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    @opportunity = Opportunity.find(params[:id])
    @users = User.all_reals
  end
  
  ##
  # Process to save an existing Opportunity
  #
  def update
    if @ability.cannot? :update, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    params[:opportunity][:profit] = params[:opportunity][:profit].gsub(' ', '')
    params[:opportunity][:amount] = params[:opportunity][:amount].gsub(' ', '')
    @opportunity = Opportunity.find(params[:id])
    @opportunity.updated_by = current_user.id
    
    if params[:opportunity][:amount].blank?
      params[:opportunity][:amount] = 0
    end

    if params[:opportunity][:profit].blank?
      params[:opportunity][:profit] = 0
    end
   
    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
        if params[:mail] == 'yes'
          UserMailer.mail_for(@opportunity.user, @opportunity, true).deliver
        end
        if !@opportunity.account_id.blank?
            format.html  { redirect_to account_events_url(@opportunity.account_id), :notice => "L'opportunité a été mise à jour." }
        else
            format.html  { redirect_to opportunities_url, :notice => "L'opportunité a été mise à jour." }
        end
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end
  
  ##
  # Process to remove an existing opportunity from the database
  #
  def destroy
    if @ability.cannot? :destroy, Opportunity
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Opportunity'))
      redirect_to opportunities_url
	  return false
    end
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy
   
    respond_to do |format|
      format.html { redirect_to (!@opportunity.account.nil? ? account_events_path(@opportunity.account) : opportunities_url), :notice => "L'opportunité a bien été supprimée."  }
    end
  end
  
  ##
  # Render a part of Contacts by Account
  #
  def update_contact_select
    contacts = Contact.where(:account_id => params[:id]).order(:surname)
    render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end
    
    def opportunities 
      @account ? @account.opportunities : Opportunity
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
end
