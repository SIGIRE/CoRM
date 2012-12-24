# encoding: utf-8
class Devi < ActiveRecord::Base
  
  attr_accessible :items_attributes
  
  #nécessaire pour la modif de ces champs avec un nested form
  attr_accessible :ref, :date, :compte_id, :ref_compte, :user_id, :validite, :mode_reg, :statut, :opportunite_id, :fichier_joint, :contact_id, :modele_id
  
  belongs_to :opportunite
  belongs_to :contact
  belongs_to :compte
  belongs_to :user
  belongs_to :modele
  
  
  has_many :items, :dependent => :destroy
  #on spécifie qu'on accède au params des items depuis le controller et les views du devis
  accepts_nested_attributes_for :items , :allow_destroy => true,
    :reject_if => lambda { |a| a[:ref].blank? || a[:quantite].blank? || a[:prix_ht].blank?}
  
  has_attached_file :fichier_joint
  
  STATUTS = ["Sauvegardé", "En cours", "Accepté", "Refusé"]

  monetize :total_ht_cents
  monetize :total_tva_cents
  monetize :total_ttc_cents


  scope :by_compte, lambda { |compte| where("compte_id = ?", compte.id) unless compte.nil? }
end
