# encoding: utf-8

class DevisController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @devis = Devi.order('ref').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @devis}
    end
    
  end
  
  
  def new
    @devi = Devi.new
    @devi.user = current_user
    @devi.compte_id = params[:compte_id]
    
    #on crée un item par défaut
    1.times { @devi.items.build }
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @devi }
    end

  end
  
  def create
    @devi = Devi.new(params[:devi])
    @devi.created_by = current_user.nom_complet
    
    @devi.societe = @devi.compte.societe unless @devi.compte.nil?
    @devi.adresse1 = @devi.compte.adresse1 unless @devi.compte.nil?
    @devi.adresse2 = @devi.compte.adresse2 unless @devi.compte.nil?
    @devi.cp = @devi.compte.cp unless @devi.compte.nil?
    @devi.ville = @devi.compte.ville unless @devi.compte.nil?
    @devi.pays = @devi.compte.pays unless @devi.compte.nil?
    @devi.nom = @devi.contact.nom unless @devi.contact.nil?
    @devi.prenom = @devi.contact.prenom unless @devi.contact.nil?
    @devi.civilite = @devi.contact.civilite unless @devi.contact.nil?
    @devi.fonction = @devi.contact.fonction unless @devi.contact.nil?
    
    
    #initialisation des variables pour les calculs de prix et total
    @devi.total_ht = 0
    @devi.taux_tva = 19.60
    

    
    #calcul effectué pour chaque item du devis
    @devi.items.each do |i|
      if !i.quantite.nil? && !i.prix_ht.nil? then
        i.total_ht = i.prix_ht * i.quantite
        @devi.total_ht += i.total_ht
      else
        i.total_ht = 0
      end
    end
    
    @devi.total_tva = @devi.total_ht*(@devi.taux_tva/100)
    @devi.total_ttc = @devi.total_ht+@devi.total_tva    
    
    respond_to do |format|
      if @devi.save
        self.create_event(false)
        format.html  { redirect_to compte_evenements_url(@devi.compte_id), :notice => "Le devis a été créé" }
        format.json  { render :json => @devi,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @devi.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @devi = Devi.find(params[:id])
  end

  def update
    @devi = Devi.find(params[:id])
    
    @devi.update_attributes(params[:devi])
    
    @devi.updated_by = current_user.nom_complet
    
    @devi.societe = @devi.compte.societe unless @devi.compte.nil?
    @devi.adresse1 = @devi.compte.adresse1 unless @devi.compte.nil?
    @devi.adresse2 = @devi.compte.adresse2 unless @devi.compte.nil?
    @devi.cp = @devi.compte.cp unless @devi.compte.nil?
    @devi.ville = @devi.compte.ville unless @devi.compte.nil?
    @devi.pays = @devi.compte.pays unless @devi.compte.nil?
    @devi.nom = @devi.contact.nom unless @devi.contact.nil?
    @devi.prenom = @devi.contact.prenom unless @devi.contact.nil?
    @devi.civilite = @devi.contact.civilite unless @devi.contact.nil?
    @devi.fonction = @devi.contact.fonction unless @devi.contact.nil?    
    
    #initialisation
    @devi.total_ht = 0
    
    #calcul pour chaque item
    @devi.items.each do |i|
      if !i.quantite.nil? && !i.prix_ht.nil? then
        i.total_ht = i.prix_ht * i.quantite
        @devi.total_ht += i.total_ht
      else
        i.total_ht = 0
      end
    end
    
    @devi.total_tva = @devi.total_ht*(@devi.taux_tva/100)
    @devi.total_ttc = @devi.total_ht+@devi.total_tva
    
    if @devi.save #update_attributes(params[:devi])
      self.create_event(true)
      redirect_to compte_evenements_url(@devi.compte_id), :notice => "Le devis a été modifié"
    else
      render :action => 'edit'
    end
  end


  
  def show
    @devi = Devi.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @devi }
      format.pdf do
        pdf = DevisPdf.new(@devi, view_context)
        send_data pdf.render, filename: "devis_#{@devi.created_at.strftime("%d/%m/%Y")}.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
  
  end
  
  
  
  def destroy
    @devi = Devi.find(params[:id])
    @devi.destroy
    redirect_to devis_url, :notice => "Le devis a été supprimé."
  end
  
  #methode appelée pour la génération dynamique de liste des contacts en fonction du compte 
  def update_contact_select
    contacts = Contact.where(:compte_id => params[:id]).order(:nom)
    render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  #methode appelée pour la génération dynamique de liste des copportunites en fonction du compte
  def update_opportunite_select
    opportunites = Opportunite.where(:compte_id => params[:id]).order(:nom)
    render :partial => "opportunites" , :locals =>{:opportunites => opportunites }  
  end
  
  
  def create_event(bool)
    #hash typé pour les params d'un evenement
    hash = Hash.new
    #hash["type_id"] = Type.where('UPPER(libelle) = "DEVIS" and UPPER(sens) = "SORTANT"')
    hash["compte_id"] = params[:devi][:compte_id]
    hash["contact_id"] = params[:devi][:contact_id]
    hash["debut"] = Time.now
    hash["fin"] = hash["debut"]

    numdevis = (params[:id])

    if(bool == true)
      hash["modified_by"] = current_user.nom_complet
      hash["notes"] = "Devis n°" + numdevis.to_s + " modifié."
    else
      hash["created_by"] = current_user.nom_complet
      hash["notes"] = "Devis n°" + @devi.id.to_s + " créé."
    end
    
    @evenement = Evenement.create(hash)
  end
  
end
