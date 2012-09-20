# encoding: utf-8

class EvenementsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /evenements     Compte.order("societe").page(params[:page]).per(3)
  # GET /evenements.json
  def index
    
    if params[:compte_id] == nil  then
      @evenements = Evenement.page(params[:page])
    else
      @compte = Compte.find(params[:compte_id])    
      @evenements = @compte.evenements.order("debut DESC").page(params[:page])
      @evenement_nouveau = @compte.evenements.build 
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @evenements }
    end
  end

  # GET /evenements/1
  # GET /evenements/1.json
  def show
    @evenement = Evenement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @evenement }
    end
  end

  # GET /evenements/new
  # GET /evenements/new.json
  def new
    @evenement = Evenement.new
    @evenement.compte_id = params[:compte_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @evenement }
    end
  end

  # GET /evenements/1/edit
  def edit
    @evenement = Evenement.find(params[:id])
  end

  # POST /evenements
  # POST /evenements.json
  def create
    @evenement = Evenement.new(params[:evenement])
    @evenement.created_by = current_user.nom_complet
    #@evenement.modified_by = current_user.email
   
    #si le checkbox est cochée 
    if params[:generate]=="yes"
      #on génère une tâche
      self.create_tache
    end
    
    
    respond_to do |format|
      if @evenement.save
        format.html { redirect_to compte_evenements_url(@evenement.compte_id), :notice => "L'évènement a été créé." }
        format.json { render :json => @evenement, :status => :created, :location => @evenement }
      else
        format.html { render :action => "new" }
        format.json { render :json => @evenement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evenements/1
  # PUT /evenements/1.json
  def update
    @evenement = Evenement.find(params[:id])
    @evenement.modified_by = current_user.nom_complet
    
    respond_to do |format|
      if @evenement.update_attributes(params[:evenement])
        format.html { redirect_to @evenement, :notice => "L'évènement a été mis à jour." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @evenement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evenements/1
  # DELETE /evenements/1.json
  def destroy
    @evenement = Evenement.find(params[:id])
    @evenement.destroy

    respond_to do |format|
      format.html { redirect_to compte_evenements_url(@evenement.compte_id) }
      format.json { head :no_content }
    end
  end
  
  
  #methode gérant la création d'une tache depuis un évènement
  def create_tache
    
    #création d'un hash ayant les mêmes clés qu'un hash renvoyé en params depuis la création d'une tache,
    #dans lequel on instaure les valeurs souhaitées
    hash = Hash.new
    hash["compte_id"] = params[:evenement][:compte_id]
    hash["contact_id"] = params[:evenement][:contact_id]
    hash["user_id"] = params[:user_id]
    hash["notes"] = params[:notes]
    hash["statut"] = params[:statut][:statut]
    hash["echeance"] = params[:echeance].split('/').reverse!.join('/')
    hash["created_by"] = current_user.nom_complet
    
    #on crée la tache à partir du hash
    @tache = Tache.create(hash)
    @evenement.tache_id = @tache.id

    #si le checkbox est cochée 
    if params[:mail]=="yes"
        #mailing
        UserMailer.create_tache_email(@tache.user,@tache).deliver
    end

  end
  
end
