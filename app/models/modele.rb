class Modele < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :devis
  has_attached_file :fichier_joint
  
end
