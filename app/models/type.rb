class Type < ActiveRecord::Base
  has_many :evenements
  
  paginates_per 10
  
  def type_complet
    "#{libelle} #{direction}"
  end  
    
  scope :by_nom, lambda { |nom| where("libelle LIKE ?", nom+'%') }
  
end
