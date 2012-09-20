class Compte < ActiveRecord::Base
  
  has_many :contacts
  has_many :evenements
  has_many :taches
  has_many :documents
  has_many :relations
  
  has_and_belongs_to_many :produits
  
  belongs_to :user
  belongs_to :origine

  
  paginates_per 10
  
  GENRES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire','Autre']
  validates_inclusion_of :genre, :in => GENRES
  
  accepts_nested_attributes_for :evenements
  accepts_nested_attributes_for :contacts
  
  #scope aide pour faire des tris sur les critères présents dans les filtres notamment
  scope :by_societe, lambda { |societe| where("societe LIKE UPPER(?)", societe)unless societe.nil? }
  scope :by_contact, lambda {|contact| joins(:contacts).where('contacts.id = ?', contact.id) unless contact.nil?}
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }
  
end
