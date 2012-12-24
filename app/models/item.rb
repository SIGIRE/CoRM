class Item < ActiveRecord::Base
  belongs_to :devi
  
  monetize :prix_ht_cents
  monetize :total_ht_cents
  
def quantite=(quantite)
  write_attribute(:quantite, quantite.gsub(',', '.'))
end  
  
  
end
