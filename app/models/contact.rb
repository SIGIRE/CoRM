class Contact < ActiveRecord::Base
  
  has_many :taches
  
  has_and_belongs_to_many :produits
  
  belongs_to :compte

  
  paginates_per 10

  def nom_complet
    "#{civilite} #{prenom} #{nom}"
  end
  
  CIVILITES = ["M.", "Mme"]
  #CONTACTS_EXPORT_COLUMNS = ['id', 'nom', 'prenom', 'civilite', 'tel', 'fax', 'mobile', 'email', 'fonction']
  
  
  scope :classe_par_nom, :order => 'nom'
  
  scope :by_societe, lambda { |societe| joins(:compte).where("comptes.societe LIKE UPPER(?)", societe)unless societe.blank? }
  scope :by_nom, lambda { |nom| where('nom LIKE UPPER (?)', nom) unless nom.blank?}
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }

  scope :by_comptes, lambda { |comptes| where("compte_id IN (?)", comptes)unless comptes.blank? }
  scope :by_tags, lambda { |tags| joins(:produits).where("produits.id IN (?)", tags) unless tags.blank? }  
  scope :by_cp_compte, lambda { |cp_compte| joins(:compte).where("comptes.cp LIKE ?", cp_compte + '%') unless cp_compte.blank? } 
  scope :by_pays_compte, lambda { |pays_compte| joins(:compte).where("comptes.pays" => pays_compte) unless pays_compte.blank? } 
  scope :by_genre_compte, lambda { |genre_compte| joins(:compte).where("comptes.genre IN ?", genre_compte) unless genre_compte.blank? } 
  scope :by_origine_compte, lambda { |origine_compte| joins(:compte).where("comptes.origine_id IN ?", origine_compte) unless origine_compte.blank? } 
  scope :by_user_compte, lambda { |user_compte| joins(:compte).where("comptes.user_id" => user_compte) unless user_compte.blank? } 

  
  
  #def self.to_csv (options = {})
  #require 'csv'
  #CSV.generate(options) do |csv|
  #  csv << CONTACTS_EXPORT_COLUMNS
  #  all.each do |contact|
  #    csv << (contact.attributes.values_at(*CONTACTS_EXPORT_COLUMNS)
  #  end
  #end
  #end
  
end
