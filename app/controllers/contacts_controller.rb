# encoding: utf-8

class ContactsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.order("nom").page(params[:page])
    
    #infos typeahead
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    @contact.created_by = current_user.nom_complet

    #gestion de la relation has and belongs to many entre comptes et produits
    #s'il n'y a plus aucun produit associé, on supprime les liens
    if params[:display_contact_produit].nil?
      @contact.produits.clear
    #sinon on recrée tous les liens avec les produits, dont les nouveaux produits
    else
      produit = Produit.find(params[:display_contact_produit])
      @contact.produits.clear
      @contact.produits << produit
    end
        
    respond_to do |format|
      if @contact.save
        format.html {
          if  (@contact.compte).nil?  then redirect_to contacts_path, :notice => 'Le contact a été créé.'
          else redirect_to compte_evenements_url(@contact.compte_id), :notice => "Le contact a été créé."
          end
        }
        
        format.json { render :json => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    @contact.modified_by = current_user.nom_complet
    
    #même traitement qu'a la creation
    if params[:display_contact_produit].nil?
      @contact.produits.clear
    else
      produit = Produit.find(params[:display_contact_produit])
      @contact.produits.clear
      @contact.produits << produit
    end

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html {
          if  (@contact.compte).nil?  then redirect_to contacts_path, :notice => 'Le contact a été mis à jour.'
          else redirect_to compte_evenements_url(@contact.compte_id), :notice => 'Le contact a été mis à jour.'
          end }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
  
  
  #gestion des filtres
  def filter

    #infos typeahead
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)

    #données du filtre
    societe = params[:filter][:societe]
    nom = params[:filter][:nom]
    tel = params[:filter][:tel]

    #tri sur les contacts en fonction des valeurs des filtres
    @contacts = Contact.by_societe(societe).by_nom(nom).by_tel(tel)
    @contacts = @contacts.order("nom ASC").page(params[:page])
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @contacts }
    end
  end
  
  
  
end
