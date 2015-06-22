# encoding: utf-8

##
# This class manage Document
#
class DocumentsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_account, :load_settings, only: [:index, :filter]
  layout :current_layout

  ##
  # Show the full list of Document by paginate_by
  #
  # GET /documents
  # GET /documents.json
  def index
    @documents = documents.order('name').page(params[:page])
   
    flash.now[:alert] = "Pas de documents !" if @documents.empty?

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
    
		if @document.save
			e = Event.new({
				:account_id => @document.account_id,
				:created_by => current_user.id,
				:notes => "Document n°#{@document.id} créé\r\nNom : #{@document.name}\r\nDescription : #{@document.notes}",
				:user_id => current_user.id,
				:date_begin => Time.now,
				:date_end => Time.now })
			e.save
			redirect_to session.delete(:return_to) || account_events_url(@document.account_id), :notice => 'Le document a été créé'
		else
			render :action => "new"
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
        format.html  { redirect_to session.delete(:return_to) || account_events_url(@document.account_id) , :notice => 'Le document a ete mis a jour.' }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
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
      format.html { redirect_to session.delete(:return_to) || account_events_url(@document.account_id), :notice => "Le document a bien été supprimé." }
      format.json { head :no_content }
    end
  end
  
  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end
    
    def load_settings
      #ClickToCall
      @setting = Setting.all.first
    end    
    
    def documents
      @account ? @account.documents : Document
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
end
