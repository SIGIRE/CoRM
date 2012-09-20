# encoding: utf-8
class Opportunite < ActiveRecord::Base
  
  belongs_to :contact
  belongs_to :compte
  belongs_to :user
  
  paginates_per 10
  
  STATUTS = ["Détectée", "En cours", "Gagnée", "Perdue"]
  validates_inclusion_of :statut, :in => STATUTS
  
  has_attached_file :fichier_joint
  
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_compte, lambda { |compte| where("compte_id = ?", compte.id) unless compte.nil? }
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_user, lambda { |user| where( "user_id = ?", user) unless user.blank? }
  scope :by_echeance, lambda { |debut,fin|  where( "echeance BETWEEN ? AND ? OR echeance IS NULL", '%'+debut, fin+'%')}
  
end
