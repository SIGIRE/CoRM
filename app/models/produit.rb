class Produit < ActiveRecord::Base
  has_many :contact
  has_and_belongs_to_many :comptes
  has_and_belongs_to_many :contacts
  
  paginates_per 10
end
