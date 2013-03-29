# encoding: utf-8

##
# This class manage Document
#
class DocumentsController < ApplicationController
  
  ##
  # Show the full list of Document by paginate_by
  #
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.order('name').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @documents }
    end
  end
  
  ##
  # Render the page to create a new Document
  #
  def new
    @document = Document.new
    @document.account_id = params[:account_id]
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @document }
    end
  end
  
  ##
  # Process to add a new Document into the DB
  #
  def create
    @document = Document.new(params[:document])
    @document.created_by = current_user.id
    
    respond_to do |format|
      if @document.save
        format.html  { redirect_to account_events_url(@document.account_id), :notice => 'Le document a été créé' }
        format.json  { render :json => @document,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @document.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render the page to show one Document
  #
  def show
    @document = Document.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @document }
    end
  end
  
  ##
  # Render the page to edit an existing Document
  #
  def edit
    @document = Document.find(params[:id])
  end
  
  ##
  # Process to update an existing Document
  #
  def update
    @document = Document.find(params[:id])
    @document.updated_by = current_user.id
   
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html  { redirect_to account_events_url(@document.account_id) , :notice => 'Le document a ete mis a jour.' }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Process to destroy a document defined by this ID
  #
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
   
    respond_to do |format|
      format.html { redirect_to account_events_url(@document.account_id) }
      format.json { head :no_content }
    end
  end
  
end
