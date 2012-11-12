# encoding: utf-8

class TachesController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /taches
  # GET /taches.json
  def index
    @page = params[:page]
    @taches = Tache.where("user_id =? AND statut IN ('En cours','A faire')", current_user).order("statut ASC ,echeance ASC").page(@page)
    
    #infos typeahead --> plus nécessaires si pas de champ Compte/contact dans le partial filter
    #@autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    #@autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)
          
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @taches , :filter => @filter }
    end
  end

  # GET /taches/1
  # GET /taches/1.json
  def show
    @tache = Tache.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tache }
    end
  end

  # GET /taches/new
  # GET /taches/new.json
  def new
    @tache = Tache.new
    @tache.user = current_user
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tache }
    end
  end

  # GET /taches/1/edit
  def edit
    @tache = Tache.find(params[:id])
    
    #conversion de la string echeance pour qu'elle soit formatté correctement pour l'afficahge
    @tache.echeance = @tache.echeance.split('/').reverse!.join('/')
  end

  # POST /taches
  # POST /taches.json
  def create
    @tache = Tache.new(params[:tache])
    @tache.created_by = current_user.nom_complet
    @tache.modified_by = current_user.nom_complet
    
    #idem que dans edit
    @tache.echeance = @tache.echeance.split('/').reverse!.join('/')
    
    
    respond_to do |format|
      if @tache.save
        
	#si le checkbox est cochée 
	if params[:mail]=="yes"
	  #mailing
	  UserMailer.create_tache_email(@tache.user,@tache).deliver
	end
        
        #pour que la tache ait un id 
        self.create_event(false)
        format.html { redirect_to taches_path, :notice => 'La tâche a été créée.' }
        format.json { render :json => @tache, :status => :created, :location => @tache }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tache.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taches/1
  # PUT /taches/1.json
  def update
    @tache = Tache.find(params[:id])
    @tache.modified_by = current_user.nom_complet
    params[:tache][:echeance] = params[:tache][:echeance].split('/').reverse!.join('/')
        
    respond_to do |format|
      if @tache.update_attributes(params[:tache])
        
	#si le checkbox est cochée 
	if params[:mail]=="yes"
	  #mailing
	  UserMailer.update_tache_email(@tache.user,@tache).deliver
	end
        
        self.create_event(true)
        format.html { redirect_to taches_url, :notice => 'La tâche a été mise à jour.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tache.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taches/1
  # DELETE /taches/1.json
  def destroy
    @tache = Tache.find(params[:id])
    @tache.destroy

    respond_to do |format|
      format.html { redirect_to taches_url }
      format.json { head :no_content }
    end
  end
  
  #methode pour la génération dynamique de la liste de contacts en fonction du compte
  def update_contact_select
    contacts = Contact.where(:compte_id => params[:id]).order(:nom)
    render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  #methode pour la gestion du filtre
  def filter
    
    #pour que l'autocompletion fonctionne même après une recherche
    #@autocomplete_comptes = Compte.find(:all,:select=>'societe').map(&:societe)
    #@autocomplete_contacts = Contact.find(:all,:select=>'nom').map(&:nom)
    
    #données du filtre
    #societe = params[:filter][:compte]
    if params.has_key?(:filter) then
      @email_filter = params[:filter][:user_email]
      @statut_filter = params[:filter][:statut]
    else
      @email_filter = current_user.email
      @statut_filter = "Non terminé"
    end
    
    
    #@statut_filter = params[:filter][:statut]
    #nom_contact = params[:filter][:contact]
    #debut = params[:filter][:debut]
    #fin = params[:filter][:fin]
    
    #convertir date au format yyyy/mm/dd
    #if debut ==""
    #  #debut = Date.today.to_s.split("-").join("/")
    #  debut ="0000/00/00"
    #else
    #  debut = debut.split('/').reverse!.join('/')
    #end
    
    #if fin ==""
    #  fin = "9999/99/99"
    #else
    #  fin = fin.split('/').reverse!.join('/')
    #end
    
    
    #recherche le compte ayant pour societe = compte du filtre
    # compte = Compte.find(:first , :conditions => ['societe LIKE UPPER(?)', societe])
    
    #recherche le user ayant pour mail = mail du filtre
    user = User.find(:first, :conditions => ['email LIKE ?', @email_filter])
    
    #if nom_contact!=""
    ##recherche le contact ayant pour nom = contact du filtre
    #contact = Contact.find(:first, :conditions => ['nom LIKE UPPER(?)', nom_contact])
    #end

    #tri sur les taches en fonction des valeurs du filtre
    if @statut_filter == "Non terminé" then
	@taches = Tache.by_statut_non_termine(@statut_filter).by_user(user)
    else
        @taches = Tache.by_statut(@statut_filter).by_user(user)
    end
    
    @taches = @taches.order("echeance ASC,statut DESC").page(params[:page])
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @taches, :filter => @filter }
    end

  end

  #creation d'un evenement depuis une tache, le boolean en parametre permet de savoir si c'est un evenement
  # pour la creation d'une tache ou pour l'update d'une tache
  def create_event(bool)
    
    #hash typé pour les params d'un evenement
    hash = Hash.new
    hash["type_id"] = params[:type][:id]
    hash["compte_id"] = params[:tache][:compte_id]
    hash["contact_id"] = params[:tache][:contact_id]
    hash["debut"] = Time.now
    hash["fin"] = hash["debut"]
    hash["notes"] = params[:notes]
    hash["notes2"] = params[:tache][:notes]
    
    #à tester
    if(bool == true)
      hash["modified_by"] = current_user.nom_complet
    else
      hash["created_by"] = current_user.nom_complet
    end
    
    hash["tache_id"] = @tache.id
    @evenement = Evenement.create(hash)
  end
  
end

