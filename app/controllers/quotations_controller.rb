# encoding: utf-8

class QuotationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @quotations = Quotation.order('ref').page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @quotation }
    end
    
  end
 
  def get_companies
    partial_company_name = params[:company]

    if partial_company_name.blank?
      companies = Quotation.select("DISTINCT quotations.company")
                           .map { |quotation| quotation.company }
    else
      companies = Quotation.select("DISTINCT quotations.company")
                           .where("UPPER(quotations.company LIKE UPPER(?)", partial_company_name)
                           .map { |quotation| quotation.company }
    end

    respond_to do |format|
      format.json { render :json => companies }
    end
  end

  def get_contacts
    company = params[:company]
    contacts = Quotation.select("DISTINCT quotations.title, quotations.forename, quotations.surname")
                        .where("UPPER(company) = UPPER(?)", company)
                        .map { |quotation| "#{quotation.title} #{quotation.forename} #{quotation.surname}" }

    respond_to do |format|
      format.json { render :json => contacts }
    end
  end

  def filter
    # Filter params
    statut = params[:filter][:statut]
    account_company = params[:filter][:account]
    contact_id = params[:filter][:contact_id]
    user_id = params[:filter][:user]

    # Finding results
    @quotations = Quotation.by_statut(statut)
                           .by_account_company_like(account_company)
                           .by_contact_id(contact_id)
                           .by_user_id(user_id)
                           .order('ref')
                           .page(params[:page])

    respond_to do |format|
      format.html { render :action => :index }
      format.json { render :json => @quotation }
    end
  end
  
  def new
    if @ability.cannot? :create, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @users = User.all_reals
    @quotation = Quotation.new(params[:quotation])
    @quotation.user = current_user
    @quotation.account_id = params[:account_id]
    if (!params[:account_id].blank?)
      @quotation.account = Account.find(params[:account_id]);
    end
    
    # Instanciate a default line
    1.times { @quotation.quotation_lines.build }
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @quotation }
    end

  end
  
  ##
  # Process to create a new Quotation into the DB
  #   Calculate the total_excl_tax, total_incl_tax, price and VAT
  #
  def create
    if @ability.cannot? :create, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @quotation = Quotation.new(params[:quotation])
    @quotation.created_by = current_user.id
    if !@quotation.account.nil?
			@quotation.company = @quotation.account.company
			@quotation.adress1 = @quotation.account.adress1
			@quotation.adress2 = @quotation.account.adress2
			@quotation.zip = @quotation.account.zip
			@quotation.city = @quotation.account.city
			@quotation.country = @quotation.account.country
			if !@quotation.contact.nil?
				@quotation.surname = @quotation.contact.surname
				@quotation.forename = @quotation.contact.forename
				@quotation.title = @quotation.contact.title
				@quotation.job = @quotation.contact.job
			end	
		end

    # Store variables to calculate price & total
    @quotation.total_excl_tax = 0
    @quotation.VAT_rate = @quotation.quotation_template.vat_rate
    # For each lines, calculate the total exclude taxes
    @quotation.quotation_lines.each do |line|
      if !line.quantity.nil? && !line.price_excl_tax.nil? then
        line.total_excl_tax = line.price_excl_tax * line.quantity
        @quotation.total_excl_tax += line.total_excl_tax
      else
        line.total_excl_tax = 0
      end
    end
    # VAT and including taxes
    @quotation.total_VAT = @quotation.total_excl_tax * (@quotation.VAT_rate / 100)
    @quotation.total_incl_tax = @quotation.total_excl_tax + @quotation.total_VAT
		if @quotation.save
			self.create_event(false)
			redirect_to (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => "Le devis a été créé."
		else
			flash[:error] = t('app.save_undefined_error')
			render :action => "new"
		end
  end
  
  ##
  # Render the page to edit one Quotation
  #
  def edit
    if @ability.cannot? :update, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @users = User.all_reals
    @quotation = Quotation.find(params[:id])
  end

  ##
  # Process to save a Quotation already existant into the DB
  #
  def update
    if @ability.cannot? :update, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @quotation = Quotation.find(params[:id])
    
    @quotation.update_attributes(params[:quotation])
    
    @quotation.updated_by = current_user.id
    if !@quotation.account.nil?
			@quotation.company = @quotation.account.company
			@quotation.adress1 = @quotation.account.adress1
			@quotation.adress2 = @quotation.account.adress2
			@quotation.zip = @quotation.account.zip
			@quotation.city = @quotation.account.city
			@quotation.country = @quotation.account.country
			if !@quotation.contact.nil?
				@quotation.surname = @quotation.contact.surname
				@quotation.forename = @quotation.contact.forename
				@quotation.title = @quotation.contact.title
				@quotation.job = @quotation.contact.job
			end
		else
			@quotation.company = ''
			@quotation.adress1 = ''
			@quotation.adress2 = ''
			@quotation.zip = ''
			@quotation.city = ''
			@quotation.country = ''
			@quotation.surname = ''
			@quotation.forename = ''
			@quotation.title = ''
			@quotation.job = ''
		end
    
    #initialisation
    @quotation.VAT_rate = @quotation.quotation_template.vat_rate
    @quotation.total_excl_tax = 0
    
    # For each lines, calculate the total exclude taxes
    @quotation.quotation_lines.each do |line|
      if !line.quantity.nil? && !line.price_excl_tax.nil? then
        line.total_excl_tax = line.price_excl_tax * line.quantity
        @quotation.total_excl_tax += line.total_excl_tax
      else
        line.total_excl_tax = 0
      end
    end
    
    # VAT and including taxes
    @quotation.total_VAT = @quotation.total_excl_tax * (@quotation.VAT_rate / 100)
    @quotation.total_incl_tax = @quotation.total_excl_tax + @quotation.total_VAT
    
    if @quotation.save
      self.create_event(true)
			redirect_to (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => "Le devis a été modifié."
    else
      flash[:error] = t('app.save_undefined_error')
      render :action => 'edit'
    end
  end


  ##
  # Render one occurence of Quotation with their QuotationLine
  #
  def show
    if @ability.cannot? :read, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @quotation = Quotation.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @quotation }
      format.pdf do
        pdf = QuotationPdf.new(@quotation, view_context)
        send_data pdf.render, filename: "quotation_#{@quotation.created_at.strftime("%d/%m/%Y")}.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
  
  end
  
  ##
  # Remove a Quotation from the base
  #
  def destroy
    if @ability.cannot? :destroy, Quotation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Quotation'))
      redirect_to quotations_url
	  return false
    end
    @quotation = Quotation.find(params[:id])
    @quotation.destroy
    url = @quotation.account.nil? ? quotations_path : account_events_url(@quotation.account)
    redirect_to url, :notice => "Le devis a bien été supprimé."
  end
  
  ##
  # Called to generate dynamically a Contact list per Account
  #
  def update_contact_select
    contacts = Contact.where(:account_id => params[:id]).order(:surname)
    render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  ##
  # Called to generate dynamically a Opportunity list per Account
  #
  def update_opportunity_select
    opportunities = Opportunity.where(:account_id => params[:id]).order(:name)
    render :partial => "opportunities" , :locals =>{:opportunities => opportunities }  
  end
  
  ##
  # Create an Event
  # * *Args*    :
  #   - +updated+ -> if the object is updated(true) or created(false)
  #
  def create_event(updated)
    type = updated ? :update : :create
    if @ability.cannot? type, Event
	    return false
    end
    hash = Hash.new
    hash["account_id"] = params[:quotation][:account_id]
    hash["contact_id"] = params[:quotation][:contact_id]
    hash["date_begin"] = Time.now
    hash["date_end"] = hash["date_begin"]

    quotationNum = (params[:id])

    if(updated == true)
      hash["modified_by"] = current_user.id
      hash["notes"] = "Devis n°" + quotationNum.to_s + " modifié."
    else
      hash["created_by"] = current_user.id
      hash["notes"] = "Devis n°" + @quotation.id.to_s + " créé."
    end
    
    @event = Event.create(hash)
  end
  
end
