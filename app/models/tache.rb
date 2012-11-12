# encoding: utf-8

class Tache < ActiveRecord::Base
  
  #pour la verif des changements à l'update
  include ActiveModel::Dirty
  
  belongs_to :contact
  belongs_to :compte
  belongs_to :user
  
  paginates_per 10
  
  STATUTS = ["A faire", "En cours", "Terminé", "Annulé"]
  STATUTS_A_FILTRER = STATUTS + ["Non terminé"]

  validates_inclusion_of :statut, :in => STATUTS
  
  has_attached_file :fichier_joint
  
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_statut_non_termine, lambda { |statut| where("statut IN ('A faire', 'En cours')") }
  scope :by_compte, lambda { |compte| where("compte_id = ?", compte.id) unless compte.nil? }
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_user, lambda { |user| where( "user_id = ?", user.id) unless user.nil? }
  scope :by_echeance, lambda { |debut,fin|  where( "echeance BETWEEN ? AND ? OR echeance = ?", debut, fin+'%','')}
  
end
