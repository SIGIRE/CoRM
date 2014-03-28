# encoding: utf-8

class OpportunitiesController < ApplicationController
  
  before_filter :authenticate_user!
  
  ##
  # Display the full list of Opportunities by paginate_by
  #
  def index
    
    #pour l'autocomplétion du typeahead
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company)
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname)
    
    @opportunities = Opportunity.by_user(current_user).where("statut IN ('Détectée', 'En cours')").order('term desc').page(params[:page])
    
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
  
  ##
  # AutoCompletion handler
  #
  def filter
    @autocomplete_accounts = Account.find(:all,:select=>'company').map(&:company)
    @autocomplete_contacts = Contact.find(:all,:select=>'surname').map(&:surname)
    
    # filter variables
    company = params[:filter][:account]
    user = params[:filter][:user]
    statut = params[:filter][:statut]
    contact_id= params[:filter][:contact_id]
    date_begin = params[:filter][:date_begin]
    date_end = params[:filter][:date_end]
    
    # convert date => yyyy/mm/dd
    if date_begin == ""
      date_begin = "1990-05-21 00:00:00"
    else
      # trouble on inclusion
      temp = date_begin.split('/')
      temp[0] = temp[0].to_i - 1
      date_begin = temp.reverse!.join('-') + ' 00:00:00'
    end
    
    if date_end == ""
      date_end = "2036-12-12 00:00:00"
    else
      date_end = date_end.split('/').reverse!.join('-') + ' 00:00:00'
    end
    
    # sort by filter values
    @opportunities = Opportunity.by_statut(statut)
                                .by_term(date_begin, date_end)
                                .by_account_company_like(company)
                                .by_contact_id(contact_id)
                                .by_user(user)
                                .order("term DESC,statut DESC")
                                .page(params[:page])
    
    # Get totals after an user search calcul des totaux après une recherche sur l'utilisateur
    @total_amount = 0
    @total_profit = 0
    Opportunity.by_user(user).where("statut IN ('Détectée', 'En cours')").each do |op|
      @total_amount += op.amount
      @total_profit += op.profit
    end
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @opportunities , :locals =>{:total_amount => @total_amount , :total_profit => @total_profit } }
    end

  end
  
end
