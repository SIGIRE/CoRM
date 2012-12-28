class ExtractionsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /extractions/select_param_comptes
  def select_param_comptes
  end

  # GET /extractions/select_param_contacts
  def select_param_contacts
  end


  
  def comptes
    
    require 'csv'
    require 'iconv'
    
    @comptes = Compte.by_cp(params[:code_postal]).by_pays(params[:pays]).by_tags(params[:produits]).by_user(params[:user]).by_genre(params[:genres]).by_origine(params[:origines])

    comptes_csv = CSV.generate(:col_sep => ';') do |csv|
      # header row
      csv << ['id', 'societe', 'adresse1', 'adresse2', 'cp', 'ville', 'pays', 'tel', 'fax', 'email', 'web', 'code_compta', 'genre', 'collaborateur', 'origine']
      # data row
      @comptes.each do |compte|
        csv << [compte.id, compte.societe, compte.adresse1, compte.adresse2, compte.cp, compte.ville, compte.pays, compte.tel, compte.fax, compte.email, compte.web, compte.code_compta, compte.genre, (compte.user.nom_complet unless compte.user.nil?), (compte.origine.nom unless compte.origine.nil?) ]
      end
    end

    send_data(Iconv.conv('iso-8859-1//IGNORE', 'utf-8', comptes_csv), :type => 'test/csv; charset=iso-8859-1; header=present', :filename => 'comptes.csv') 
  end
  
  
  
  
  def contacts
    require 'csv'
    require 'iconv'
    
    @contacts = Contact.by_comptes(params[:compte]).by_cp_compte(params[:code_postal]).by_pays_compte(params[:pays]).by_tags(params[:produits]).by_user_compte(params[:user]).by_genre_compte(params[:genres]).by_origine_compte(params[:origines])

    contacts_csv = CSV.generate(:col_sep => ';') do |csv|
      # header row
      csv << ['id', 'nom', 'prenom', 'civilite', 'tel', 'fax', 'email', 'mobile', 'fonction', 'societe', 'adresse1', 'adresse2', 'cp', 'ville', 'pays', 'tel_compte', 'fax_compte', 'email_compte', 'genre', 'collaborateur', 'origine']
      # data row
      @contacts.each do |contact|
        csv << [contact.id, contact.nom, contact.prenom, contact.civilite, contact.tel, contact.fax, contact.email, contact.mobile, contact.fonction, (contact.compte.societe unless contact.compte.nil?), (contact.compte.adresse1 unless contact.compte.nil?), (contact.compte.adresse2 unless contact.compte.nil?), (contact.compte.cp unless contact.compte.nil?), (contact.compte.ville unless contact.compte.nil?), (contact.compte.pays unless contact.compte.nil?), (contact.compte.tel unless contact.compte.nil?), (contact.compte.fax unless contact.compte.nil?), (contact.compte.email unless contact.compte.nil?), (contact.compte.genre unless contact.compte.nil?), (contact.compte.user.nom_complet unless (contact.compte.nil? or contact.compte.user.nil?)), (contact.compte.origine.nom unless (contact.compte.nil? or contact.compte.origine.nil?)) ]
      end
    end

    send_data(Iconv.conv('iso-8859-1//IGNORE', 'utf-8', contacts_csv), :type => 'test/csv; charset=iso-8859-1; header=present', :filename => 'contacts.csv')     
  end
  
  
end
