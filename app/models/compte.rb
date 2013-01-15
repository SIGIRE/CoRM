class Compte < ActiveRecord::Base
  
  before_save :uppercase_societe
  
  has_many :contacts
  has_many :evenements
  has_many :taches
  has_many :documents
  has_many :relations
  
  has_and_belongs_to_many :produits
  
  belongs_to :user
  belongs_to :origine

  
  paginates_per 10
  
  
  GENRES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire', 'Adhérent', 'Autre']
  validates_inclusion_of :genre, :in => GENRES
  
  #COMPTES_EXPORT_COLUMNS = ['id', 'societe', 'adresse1', 'adresse2', 'cp', 'ville', 'pays', 'tel', 'fax', 'email', 'web', 'code_compta', 'genre']
  
  accepts_nested_attributes_for :evenements
  accepts_nested_attributes_for :contacts
  
  #scope aide pour faire des tris sur les critères présents dans les filtres notamment
  scope :by_societe, lambda { |societe| where("societe LIKE UPPER(?)", societe)unless societe.nil? }
  scope :by_contact, lambda {|contact| joins(:contacts).where('contacts.id = ?', contact.id) unless contact.nil?}
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }
  scope :by_cp, lambda { |cp| where("cp LIKE ?", cp + '%') unless cp.blank? }
  scope :by_pays, lambda { |pays| where("pays = ?", pays) unless pays.blank? }  
  scope :by_tags, lambda { |tags| joins(:produits).where("produits.id IN (?)", tags) unless tags.blank? }
  scope :by_user, lambda { |user| where("user_id = ?", user) unless user.blank? }
  scope :by_genre, lambda { |genres| where("genre IN (?)", genres) unless genres.blank? }   
  scope :by_origine, lambda { |origine| where("origine_id IN (?)", origine) unless origine.blank? }   
  
  
  def uppercase_societe
    self.societe.upcase!
  end
  
  
  #def self.to_csv (options = {})
  #require 'csv'
  #CSV.generate(options) do |csv|
  #  csv << COMPTES_EXPORT_COLUMNS
  #  all.each do |compte|
  #    csv << (compte.attributes.values_at(*COMPTES_EXPORT_COLUMNS)
  #  end
  #end
  #end
  
end
