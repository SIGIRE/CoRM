# encoding: utf-8

##
# This class represents a Task. It can be done or not.
# It is defined by a status, a Description
# a final User and a term.
# It also linked with one Contact, one Account and one User
# Status may be: To Do|In progress|Finished|Cancelled
#
class Task < ActiveRecord::Base
  
  #pour la verif des changements à l'update
  include ActiveModel::Dirty
  
  belongs_to :contact
  belongs_to :account
  belongs_to :user
  
  paginates_per 10
  
  ##
  # Define the status of a Task
  # Available: To Do|In Progress|Finished|Cancelled
  #
  STATUTS = ["A faire", "En cours", "Terminé", "Annulé"]
  STATUTS_A_FILTRER = STATUTS + ["Non terminé"]

  validates_inclusion_of :statut, :in => STATUTS
  
  has_attached_file :attach
  Paperclip.interpolates :with_content_type do |attachment, style|
    "#{attachment.instance.with_content_type}"
  end
  
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_statut_non_termine, lambda { |statut| where("statut IN ('A faire', 'En cours')") }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_user, lambda { |user| where( "user_id = ?", user.id) unless user.nil? }
  scope :by_term, lambda { |date_begin,date_end|  where( "term BETWEEN ? AND ? OR echeance = ?", date_begin, date_end +'%','')}
  
end
