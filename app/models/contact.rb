class Contact < ActiveRecord::Base
  
  has_many :taches
  
  has_and_belongs_to_many :produits
  
  belongs_to :compte

  
  paginates_per 10

  def nom_complet
    "#{civilite} #{prenom} #{nom}"
  end
  
  CIVILITES = ["M.", "Mme"]
  
  scope :classe_par_nom, :order => 'nom'
  
  scope :by_societe, lambda { |societe| joins(:compte).where("comptes.societe LIKE UPPER(?)", societe)unless societe.blank? }
  scope :by_nom, lambda { |nom| where('nom LIKE UPPER (?)', nom) unless nom.blank?}
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }
  
end
