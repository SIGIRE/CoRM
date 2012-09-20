# encoding: utf-8
class DevisController < InheritedResources::Base
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
    
    #initialisation des variables pour les calculs de prix et total
    @devi.total_ht = 0
    @devi.tva = 19.60
    
    @devi.total_tva = @devi.total_ht*(@devi.tva/100)
    @devi.total_ttc = @devi.total_ht+@devi.total_tva
    
    #calcul effectué pour chaque item du devis
    @devi.items.each do |i|
      if !i.quantite.nil? && !i.prix_ht.nil?
        i.total_ht = i.quantite*i.prix_ht
        @devi.total_ht += i.total_ht
      end
    end
    
    respond_to do |format|
      if @devi.save
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
    @devi.updated_by = current_user.nom_complet
    
    #initialisation
    @devi.total_ht = 0
  
    #calcul pour chaque item
    @devi.items.each do |i|
      if !i.quantite.nil? && !i.prix_ht.nil?
        i.total_ht = i.quantite*i.prix_ht
        @devi.total_ht += i.total_ht
      end
    end
    
    @devi.total_tva = @devi.total_ht*(@devi.tva/100)
    @devi.total_ttc = @devi.total_ht+@devi.total_tva
    
    if @devi.update_attributes(params[:devi])
      redirect_to @devi, :notice => "Le devis a été mis à jour."
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
  
end
