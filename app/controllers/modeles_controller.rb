# encoding: utf-8
class ModelesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @page = params[:page]
    @modeles =  Modele.order('societe').page(@page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @modeles}
    end
    
  end  
  
  def new
    @modele = Modele.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @modele }
    end

  end
  
  def create
    @modele = Modele.new(params[:modele])
    
    respond_to do |format|
      if @modele.save
        format.html  { redirect_to devis_url, :notice => "Le modèle a été créé" }
        format.json  { render :json => @modele,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @modele.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  
  def edit
    @modele = Modele.find(params[:id])
  end

  def update
    @modele = Modele.find(params[:id])
    
    if @modele.update_attributes(params[:modele])
      redirect_to @modele, :notice => "Le modèle a été mis à jour."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @modele = Modele.find(params[:id])
    @modele.destroy
    redirect_to devis_url, :notice => "Le modèle a été supprimé."
  end
  
end
