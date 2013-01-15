class ProduitsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /produits
  # GET /produits.json
  def index
    @produits = Produit.order('nom').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @produits }
    end
  end
  
  def new
    @produit = Produit.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @produit }
    end
  end
  
  def create
    @produit = Produit.new(params[:produit])
    @produit.created_by = current_user.nom_complet
    
    respond_to do |format|
      if @produit.save
        format.html  { redirect_to produits_path, :notice => 'Le produit a ete cree' }
        format.json  { render :json => @produit,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @produit.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @produit = Produit.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @produit }
    end
  end
  
  def edit
    @produit = Produit.find(params[:id])
  end
  
  def update
    @produit = Produit.find(params[:id])
    @produit.updated_by = current_user.nom_complet
   
    respond_to do |format|
      if @produit.update_attributes(params[:produit])
        format.html  { redirect_to(produits_url, :notice => 'Le produit a ete mis a jour.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @produit.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @produit = Produit.find(params[:id])
    @produit.destroy
   
    respond_to do |format|
      format.html { redirect_to produits_url }
      format.json { head :no_content }
    end
  end
  
end
