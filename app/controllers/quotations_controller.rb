# encoding: utf-8

class QuotationsController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :load_account, :load_settings, only: [:index]
  layout :current_layout

  has_scope :by_statut
  has_scope :by_account_company_like
  has_scope :by_contact_id
  has_scope :by_user_id
  has_scope :by_author_user_id
  has_scope :by_activity_account, as: :account_activity
  has_scope :by_account_tags, as: :account_tag
  has_scope :by_origin_account, as: :account_origin

  def index
    default_order = 'date'
    default_direction = 'DESC'
    @sort = params[:sort] || default_order
    @direction = params[:direction] || default_direction

    @quotations_all = apply_scopes(quotations).order("#{@sort} #{@direction}")

    @quotations = @quotations_all.page(params[:page])

    @quotations_scopes = current_scopes

    #initialisation puis calcul des totaux
    @total_amount = 0
    @total_number = 0
    total_amount_cents = 0
    @quotations_all.each do |quotation|
      total_amount_cents += quotation.total_excl_tax_cents
      @total_number += 1
    end
    @total_amount = total_amount_cents / 100

    flash.now[:alert] = "Pas de devis !" if @quotations.empty?

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx # index.xlsx.axlsx
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

  def new
    @quotation = Quotation.new(params[:quotation])
    @quotation.user = current_user
    @quotation.account_id = params[:account_id]

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
			redirect_to session.delete(:return_to) || (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => 'Le devis a été créé.'
			#redirect_to (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => "Le devis a été créé."
		else
			flash[:alert] = @quotation.errors.full_messages.join("\n")
      render :action => "new"
    end
  end

  ##
  # Render the page to edit one Quotation
  #
  def edit
    @users = User.all_reals
    @quotation = Quotation.find(params[:id])
  end

  ##
  # Process to save a Quotation already existant into the DB
  #
  def update
    @quotation = Quotation.find(params[:id])
    @quotation_before_update = Quotation.find(params[:id])
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
      if !(@quotation.statut == @quotation_before_update.statut)      
	self.create_event(true)
      end
      redirect_to session.delete(:return_to) || (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => 'Le devis a été modifié.'
      #redirect_to (!@quotation.account.nil? ? account_events_url(@quotation.account_id) : quotations_path), :notice => "Le devis a été modifié."
    else
      flash[:error] = t('app.save_undefined_error')
      render :action => 'edit'
    end
  end


  ##
  # Render one occurence of Quotation with their QuotationLine
  #
  def show
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
    @quotation = Quotation.find(params[:id])
    @quotation.destroy
    url = @quotation.account.nil? ? quotations_path : account_events_url(@quotation.account)
    redirect_to session.delete(:return_to) || url, :notice => "Le devis a bien été supprimé."
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
    hash["quotation_id"] = @quotation.id

    if updated
      hash["modified_by"] = current_user.id
      hash["notes"] = "Devis n°" + @quotation.id.to_s + ' modifié. Le statut est passé de "' + @quotation_before_update.statut + '" à "' + params[:quotation][:statut] + '".'
    else
      hash["created_by"] = current_user.id
      hash["notes"] = "Devis n°" + @quotation.id.to_s + " créé."
    end

    @event = Event.create(hash)
  end

  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end

    def load_settings
      #ClickToCall
      @setting = Setting.all.first
    end

    def quotations
      @account ? @account.quotations : Quotation
    end

    def current_layout
      if @account && @account.persisted?
        "accounts_show"
      else
        "application"
      end
    end
end
