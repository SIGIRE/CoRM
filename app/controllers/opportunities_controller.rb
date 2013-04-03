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
    @opportunity = Opportunity.new
    @opportunity.user = current_user
    @opportunity.account_id = params[:account_id]
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @opportunity }
    end
  end
  
  ##
  # Process to save a new Opportunity
  #
  def create
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
        format.html  { redirect_to account_events_url(@opportunity.account_id), :notice => "L'opportunity a ete creee" }
        format.json  { render :json => @opportunity,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @opportunity.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render the page to edit an Opportunity
  #
  def edit
    @opportunity = Opportunity.find(params[:id])
  end
  
  ##
  # Process to save an existing Opportunity
  #
  def update
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
        format.html  { redirect_to account_events_url(@opportunity.account_id), :notice => "L' opportunity a ete mise a jour." }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Process to remove an existing opportunity from the database
  #
  def destroy
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy
   
    respond_to do |format|
      format.html { redirect_to opportunities_url }
      format.json { head :no_content }
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
    surname_contact = params[:filter][:contact]
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
    
    # Search Account with company equals to params[:filter][:account]
    account = Account.find(:first , :conditions => ['company LIKE UPPER(?)', company])
    
    if surname_contact != ""
        # Search Contact with surname == params[:filter][:contact]
        contact = Contact.find(:first, :conditions => ['surname LIKE ?', surname_contact])
    end

    # sort by filter values
    @opportunities = Opportunity.by_statut(statut).by_term(date_begin, date_end).by_account(account).by_contact(contact).by_user(user)
    @opportunities = @opportunities.order("term DESC,statut DESC").page(params[:page])
    
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
