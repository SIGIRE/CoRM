# encoding: utf-8

class OriginesController < ApplicationController

	
  before_filter :authenticate_user!
  
  # GET /origines
  # GET /origines.json
  def index
    @origines = Origine.order('nom').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @origines }
    end
  end
  
  def new
    @origine = Origine.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @origine }
    end
  end
  
  def create
    @origine = Origine.new(params[:origine])
    @origine.created_by = current_user.nom_complet
    
    respond_to do |format|
      if @origine.save
        format.html  { redirect_to origines_path, :notice => "L'origine a ete creee" }
        format.json  { render :json => @origine,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @origine.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @origine = Origine.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @origine }
    end
  end
  
  def edit
    @origine = Origine.find(params[:id])
  end
  
  def update
    @origine = Origine.find(params[:id])
    @origine.updated_by = current_user.nom_complet
   
    respond_to do |format|
      if @origine.update_attributes(params[:origine])
        format.html  { redirect_to(@origine, :notice => "L' origine a ete mis a jour.") }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @origine.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @origine = Origine.find(params[:id])
    @origine.destroy
   
    respond_to do |format|
      format.html { redirect_to origines_url }
      format.json { head :no_content }
    end
  end

end
