class Document < ActiveRecord::Base
  
  belongs_to :compte
  
  paginates_per 10
  
  has_attached_file :fichier_joint
  
  validates_attachment_presence :fichier_joint
  validates :nom,  :presence => true
  
  scope :by_compte, lambda { |compte| where("compte_id = ?", compte.id )unless compte.nil? }
end
