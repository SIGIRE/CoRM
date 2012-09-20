# encoding: utf-8
class DocumentsController < InheritedResources::Base
  
  before_filter :authenticate_user!
  
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.order('nom').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @documents }
    end
  end
  
  def new
    @document = Document.new
    @document.compte_id = params[:compte_id]
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @document }
    end
  end
  
  def create
    @document = Document.new(params[:document])
    @document.created_by = current_user.nom_complet
    
    respond_to do |format|
      if @document.save
        format.html  { redirect_to compte_evenements_url(@document.compte_id), :notice => 'Le document a été créé' }
        format.json  { render :json => @document,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @document.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @document = Document.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @document }
    end
  end
  
  def edit
    @document = Document.find(params[:id])
  end
  
  def update
    @document = Document.find(params[:id])
    @document.updated_by = current_user.nom_complet
   
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html  { redirect_to compte_evenements_url(@document.compte_id) , :notice => 'Le document a ete mis a jour.' }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
   
    respond_to do |format|
      format.html { redirect_to compte_evenements_url(@document.compte_id) }
      format.json { head :no_content }
    end
  end
  
end
