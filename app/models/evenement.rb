class Evenement < ActiveRecord::Base
  belongs_to :contact
  belongs_to :compte
  belongs_to :type
  belongs_to :user
  belongs_to :tache
  
  paginates_per 10
  
  has_attached_file :fichier_joint
  
  
end
