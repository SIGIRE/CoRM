class Produit < ActiveRecord::Base
  has_many :contact
  has_and_belongs_to_many :comptes
  has_and_belongs_to_many :contacts
  
  paginates_per 10
  
  scope :by_compte_with_contacts, lambda { |compte| where("compte_id = ?", compte.id) unless compte.nil? }
end
