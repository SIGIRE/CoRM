# encoding: utf-8

class QuotationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @quotations = Quotation.order('ref').page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @quotation}
    end
    
  end
  
  
  def new
    @quotation = Quotation.new
    @quotation.user = current_user
    @quotation.account_id = params[:account_id]
    
    # Instanciate a default line
    1.times { @quotation.quotation_lines.build } ## hum, hum
    
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
    @quotation.created_by = current_user.full_name
    
    @quotation.company = @quotation.account.company unless @quotation.account.nil?
    @quotation.adress1 = @quotation.account.adresse1 unless @quotation.account.nil?
    @quotation.adress2 = @quotation.account.adresse2 unless @quotation.account.nil?
    @quotation.zip = @quotation.account.cp unless @quotation.account.nil?
    @quotation.city = @quotation.account.ville unless @quotation.account.nil?
    @quotation.country = @quotation.account.pays unless @quotation.account.nil?
    @quotation.surname = @quotation.contact.surname unless @quotation.contact.nil?
    @quotation.forename = @quotation.contact.forename unless @quotation.contact.nil?
    @quotation.title = @quotation.contact.title unless @quotation.contact.nil?
    @quotation.job = @quotation.contact.job unless @quotation.contact.nil?
    
    # Store variables to calculate price & total
    @quotation.total_excl_tva = 0
    @quotation.VAT_rate = 19.60
    
    # For each lines, calculate the total exclude taxes
    @quotation.lines.each do |line|
      if !line.quantity.nil? && !line.prix_ht.nil? then
        line.total_excl_tax = line.prix_excl_tax * line.quantity
        @quotation.total_excl_tax += line.total_excl_tax
      else
        line.total_ht = 0
      end
    end
    
    # VAT and including taxes
    @quotation.total_VAT = @quotation.total_excl_tax * (@quotation.VAT_rate / 100)
    @quotation.total_incl_tax = @quotation.total_excl_tax + @quotation.total_VAT
    
    respond_to do |format|
      if @quotation.save
        self.create_event(false)
        format.html  { redirect_to account_events_url(@quotation.account_id), :notice => "Le devis a été créé" }
        format.json  { render :json => @quotation,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @quotation.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render the page to edit one Quotation
  #
  def edit
    @quotation = Quotation.find(params[:id])
  end

  ##
  # Process to save a Quotation already existant into the DB
  #
  def update
    @quotation = Quotation.find(params[:id])
    
    @quotation.update_attributes(params[:quotation])
    
    @quotation.updated_by = current_user.full_name
    
    @quotation.company = @quotation.account.company unless @quotation.account.nil?
    @quotation.adress1 = @quotation.account.adress1 unless @quotation.account.nil?
    @quotation.adress2 = @quotation.account.adress2 unless @quotation.account.nil?
    @quotation.zip = @quotation.account.zip unless @quotation.account.nil?
    @quotation.city = @quotation.account.city unless @quotation.account.nil?
    @quotation.country = @quotation.account.country unless @quotation.account.nil?
    @quotation.surname = @quotation.contact.surname unless @quotation.contact.nil?
    @quotation.forename = @quotation.contact.forename unless @quotation.contact.nil?
    @quotation.title = @quotation.contact.title unless @quotation.contact.nil?
    @quotation.job = @quotation.contact.job unless @quotation.contact.nil?  
    
    #initialisation
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
    
    if @quotation.save #update_attributes(params[:quotation])
      self.create_event(true)
      redirect_to account_events_url(@quotation.account_id), :notice => "Le devis a été modifié"
    else
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
    redirect_to quotation_url, :notice => "Le devis a été supprimé."
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
    hash = Hash.new
    hash["account_id"] = params[:quotation][:account_id]
    hash["contact_id"] = params[:quotation][:contact_id]
    hash["date_begin"] = Time.now
    hash["date_end"] = hash["date_begin"]

    quotationNum = (params[:id])

    if(updated == true)
      hash["modified_by"] = current_user.full_name
      hash["notes"] = "Devis n°" + quotationNum.to_s + " modifié."
    else
      hash["created_by"] = current_user.full_name
      hash["notes"] = "Devis n°" + @quotation.id.to_s + " créé."
    end
    
    @event = Event.create(hash)
  end
  
end
