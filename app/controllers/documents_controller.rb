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
    if @ability.cannot? :create, Document
      redirect_to documents_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
	  return false
    end
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
    if @ability.cannot? :create, Document
      redirect_to documents_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
	  return false
    end
    @document = Document.new(params[:document])
    @document.created_by = current_user.id
    
		if @document.save
			e = Event.new({
				:account_id => @document.account_id,
				:created_by => current_user.id,
				:notes => "Document n°#{@document.id} créé\r\nNom: #{@document.name}\r\nDescription: #{@document.notes}",
				:user_id => current_user.id,
				:date_begin => Time.now,
				:date_end => Time.now })
			e.save
			redirect_to account_events_url(@document.account_id), :notice => 'Le document a été créé'
		else
			render :action => "new"
		end
  end
  
  ##
  # Render the page to show one Document
  #
  def show
    if @ability.cannot? :read, Document
      redirect_to documents_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
	  return false
    end
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
    if @ability.cannot? :update, Document
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
      redirect_to documents_url
	  return false
    end
    @document = Document.find(params[:id])
  end
  
  ##
  # Process to update an existing Document
  #
  def update
    if @ability.cannot? :update, Document
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
      redirect_to documents_url
	  return false
    end
    @document = Document.find(params[:id])
    @document.updated_by = current_user.id
   
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html  { redirect_to account_events_url(@document.account_id) , :notice => 'Le document a ete mis a jour.' }
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
    if @ability.cannot? :destroy, Document
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Document'))
      redirect_to documents_url
	  return false
    end
    @document = Document.find(params[:id])
    @document.destroy
   
    respond_to do |format|
      format.html { redirect_to account_events_url(@document.account_id) }
      format.json { head :no_content }
    end
  end
  
end
