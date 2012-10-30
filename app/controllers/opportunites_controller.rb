# encoding: utf-8

class OpportunitesController < ApplicationController
  
  before_filter :authenticate_user!
  

  def index
    
    #pour l'autocomplétion du typeahead
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)
    
    @opportunites = Opportunite.by_user(current_user).where("statut IN ('Détectée', 'En cours')").order('nom').page(params[:page])
    
    #initialisation puis calcul des totaux
    @total_montant = 0
    @total_marge = 0
    @opportunites.each do |op|
      @total_montant += op.montant
      @total_marge += op.marge
    end
          
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @opportunites, :locals =>{:total_montant => @total_montant , :total_marge => @total_marge }  }
    end
  end
  
  def show
    @opportunite = Opportunite.find(params[:id])
   
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @opportunite }
    end
  end
    
    
  def new
    @opportunite = Opportunite.new
    @opportunite.user = current_user
    @opportunite.compte_id = params[:compte_id]
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @opportunite }
    end
  end
  
  def create
    @opportunite = Opportunite.new(params[:opportunite])
    @opportunite.created_by = current_user.nom_complet
    
    if @opportunite.montant.nil?
      @opportunite.montant = 0
    end

    if @opportunite.marge.nil?
      @opportunite.marge = 0
    end
    
    respond_to do |format|
      if @opportunite.save
        format.html  { redirect_to compte_evenements_url(@opportunite.compte_id), :notice => "L'opportunite a ete creee" }
        format.json  { render :json => @opportunite,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @opportunite.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  
  
  
  def edit
    @opportunite = Opportunite.find(params[:id])
  end
  
  def update
    @opportunite = Opportunite.find(params[:id])
    @opportunite.updated_by = current_user.nom_complet
    
    if params[:opportunite][:montant].blank?
      params[:opportunite][:montant] = 0
    end

    if params[:opportunite][:marge].blank?
      params[:opportunite][:marge] = 0
    end
   
    respond_to do |format|
      if @opportunite.update_attributes(params[:opportunite])
        format.html  { redirect_to compte_evenements_url(@opportunite.compte_id), :notice => "L' opportunite a ete mise a jour." }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @opportunite.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @opportunite = Opportunite.find(params[:id])
    @opportunite.destroy
   
    respond_to do |format|
      format.html { redirect_to opportunites_url }
      format.json { head :no_content }
    end
  end
  
  def update_contact_select
    contacts = Contact.where(:compte_id => params[:id]).order(:nom)
    render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  def filter
    
    #pour que l'autocompletion fonctionne même après une recherche
    @autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    @autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)
    
    
    #données du filtre
    societe = params[:filter][:compte]
    user = params[:filter][:user]
    statut = params[:filter][:statut]
    nom_contact = params[:filter][:contact]
    debut = params[:filter][:debut]
    fin = params[:filter][:fin]
    
    #convertir date au format yyyy/mm/dd
    if debut ==""
      debut ="1990-05-21 00:00:00"
    else
      #soucis au nivau de l'inclusion
      temp = debut.split('/')
      temp[0] = temp[0].to_i - 1
      debut = temp.reverse!.join('-') + ' 00:00:00'
    end
    
    if fin ==""
      fin = "2036-12-12 00:00:00"
    else
      fin = fin.split('/').reverse!.join('-') + ' 00:00:00'
    end
    
    
    #recherche le compte ayant pour societe = compte du filtre
    compte = Compte.find(:first , :conditions => ['societe LIKE UPPER(?)', societe])
    
    if nom_contact!=""
    #recherche le contact ayant pour nom = contact du filtre
    contact = Contact.find(:first, :conditions => ['nom LIKE UPPER(?)', nom_contact])
    end

    #tri par rapport aux valeurs du filtre
    @opportunites = Opportunite.by_statut(statut).by_echeance(debut,fin).by_compte(compte).by_contact(contact).by_user(user)
    @opportunites = @opportunites.order("echeance ASC,statut DESC").page(params[:page])
    
    #calcul des totaux après une recherche sur l'utilisateur
    @total_montant = 0
    @total_marge = 0
    Opportunite.by_user(user).where("statut IN ('Détectée', 'En cours')").each do |op|
      @total_montant += op.montant
      @total_marge += op.marge
    end
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @opportunites , :locals =>{:total_montant => @total_montant , :total_marge => @total_marge } }
    end

  end
  
end
