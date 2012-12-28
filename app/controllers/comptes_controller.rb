# encoding: utf-8

class ComptesController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /comptes
  # GET /comptes.json
  def index
    
    @comptes = Compte.order("societe").page(params[:page])
    
    #creation des ensembles contenant les comptes et contacts pour l'utilisation du typeahead
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comptes }
      #format.csv { send_data @comptes.to_csv }
    end
  end

  # GET /comptes/1
  # GET /comptes/1.json
  def show
    @compte = Compte.find(params[:id])
    session[:compte_id] = @compte.id
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @compte }
    end
  end

  # GET /comptes/new
  # GET /comptes/new.json
  def new
    @compte = Compte.new
    @compte.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @compte }
    end
  end

  # GET /comptes/1/edit
  def edit
    @compte = Compte.find(params[:id])
  end

  # POST /comptes
  # POST /comptes.json
  def create
    @compte = Compte.new(params[:compte])
    @compte.created_by = current_user.nom_complet
    @compte.modified_by = current_user.nom_complet
    
    if params[:display_compte_produit].nil?
      @compte.produits.clear
    else
      produit = Produit.find(params[:display_compte_produit])
      @compte.produits.clear
      @compte.produits << produit #unless @compte.produits.exists?(produit)
    end

    respond_to do |format|
      if @compte.save
        format.html { redirect_to comptes_path, :notice => 'Le compte a été créé.' }
        format.json { render :json => @compte, :status => :created, :location => @compte }
      else
        format.html { render :action => "new" }
        format.json { render :json => @compte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comptes/1
  # PUT /comptes/1.json
  def update
    @compte = Compte.find(params[:id])
    @compte.modified_by = current_user.nom_complet
    
    
    if params[:display_compte_produit].nil?
      @compte.produits.clear
    else
      produit = Produit.find(params[:display_compte_produit])
      @compte.produits.clear
      @compte.produits << produit #unless @compte.produits.exists?(produit)
    end
    
    respond_to do |format|
      if @compte.update_attributes(params[:compte])
        format.html { redirect_to compte_evenements_url(@compte.id), :notice => 'Le compte a été mis à jour.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @compte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comptes/1
  # DELETE /comptes/1.json
  def destroy
    @compte = Compte.find(params[:id])
    @compte.destroy

    respond_to do |format|
      format.html { redirect_to comptes_url }
      format.json { head :no_content }
    end
  end
  
  # methode appelee par la barre de recherche dans la nav bar
  def search
    societe= params[:compte]
    
    @comptes = Compte.by_societe(societe).page(params[:page])
    @compte = @comptes.first
    
     respond_to do |format|
        if !@compte.nil?
          format.html { redirect_to compte_evenements_url(@compte.id)}
          format.json { render :json => @compte }
        else
          flash.now[:error] = "Compte inconnu."
          @comptes = Compte.order('societe ASC').page(params[:page])
          format.html { render :action => "index"}
          format.json { render :json => @comptes, :status => :unprocessable_entity }
        end
    end
  end
  
  # methode pour filtrer les comptes sur la page d'index
  def filter

    #necessaire pour que le typeahead soit utilisable après un filtrage
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)

    #données du filtre
    societe = params[:filter][:societe]
    if societe.blank?
      societe = nil
    end
    nom_contact = params[:filter][:contact]
    tel = params[:filter][:tel]
    
    #pour éviter le cas du contact sans nom
    if nom_contact!=""
      #recherche le contact ayant pour nom = contact du filtre
      contact = Contact.find(:first, :conditions => ['nom LIKE UPPER(?)', nom_contact])
    end
    
    @comptes = Compte.by_societe(societe).by_contact(contact).by_tel(tel)
    @comptes = @comptes.order("societe ASC").page(params[:page])
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @comptes }
    end
  end
  
  
  def add_produit

    @produit = Produit.find(params[:produit_id])
    @compte = Compte.find(params[:compte_id])
    @compte.produits  << @produit

    respond_to do |format|
        format.html  { redirect_to compte_evenements_url(@compte.id), :notice => "Affectation du produit effectuée!" }
        format.json  { render :json => @produit}
    end    
    
  end
  
  
  def delete_produit

    @produit = Produit.find(params[:produit_id])
    @compte = Compte.find(params[:compte_id])
    @compte.produits.delete(@produit)

    respond_to do |format|
        format.html  { redirect_to compte_evenements_url(@compte.id), :notice => "Suppression de l'affectation du produit effectuée!" }
        format.json  { render :json => @produit}
    end    
    
  end
  
  
end
