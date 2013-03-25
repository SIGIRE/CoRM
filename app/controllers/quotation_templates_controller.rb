# encoding: utf-8
class QuotationTemplatesController < ApplicationController
  before_filter :authenticate_user!
  
  ##
  # Show the full list of QuotationTemplate ordered by company by paginate_by
  #
  def index
    @page = params[:page]
    @templates =  QuotationTemplate.order('company').page(@page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @templates}
    end
    
  end  
  
  ##
  # Render the page to create a new QuotationTemplate
  #
  def new
    @template = QuotationTemplate.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @template }
    end

  end
  
  ##
  # Process to create a new QuotationTemplate
  #
  def create
    @template = QuotationTemplate.new(params[:template])
    
    respond_to do |format|
      if @template.save
        format.html  { redirect_to quotations_url, :notice => "Le modèle a été créé" }
        format.json  { render :json => @template,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @template.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render the page to edit a QuotationTemplate
  #
  def edit
    @template = QuotationTemplate.find(params[:id])
  end

  ##
  # Process to update an existing QuotationTemplate
  #
  def update
    @template = QuotationTemplate.find(params[:id])
    
    if @template.update_attributes(params[:template])
      redirect_to templates_url, :notice => "Le modèle a été mis à jour."
    else
      render :action => 'edit'
    end
  end
  
  ##
  # Delete a QuotationTemplate in the Database
  #
  def destroy
    @template = QuotationTemplate.find(params[:id])
    @template.destroy
    redirect_to quotations_url, :notice => "Le modèle a été supprimé."
  end
  
end
