# encoding: utf-8

##
# This class represents a Task. It can be done or not.
# It is defined by a status, a Description
# a final User and a term.
# It also linked with one Contact, one Account and one User
# Status may be: To Do|In progress|Finished|Cancelled
#
class Task < ActiveRecord::Base
  resourcify
  #pour la verif des changements à l'update
  include ActiveModel::Dirty

  
  belongs_to :contact
  belongs_to :account
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  
  paginates_per 10
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  ##
  # Define the status of a Task
  # Available: To Do|In Progress|Finished|Cancelled
  #
  STATUTS = ["A faire", "En cours", "Terminé", "Annulé"]
  STATUTS_A_FILTRER = STATUTS + ["Non terminé"]

  validates_inclusion_of :statut, :in => STATUTS
  
  
  ##
  # Define the priorities of a Task
  #
  PRIORITIES = ["Bas", "Normal", "Haut", "Urgent"]
  PRIORITIES_A_FILTRER = PRIORITIES
  
  validates_inclusion_of :priority, :in => PRIORITIES
  
  has_attached_file :attach
  Paperclip.interpolates :with_content_type do |attachment, style|
    "#{attachment.instance.with_content_type}"
  end
  
  #scope :by_priority, lambda { |priority| where("priority = ?", priority) }
  scope :by_priority, lambda { |priority| where("priority = ?", priority) }
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_statut_non_termine, lambda { |statut| where("statut IN ('A faire', 'En cours')") }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_user, lambda { |user| where( "user_id = ?", user.id) unless user.nil? }
  scope :by_term, lambda { |date_begin,date_end|  where( "term BETWEEN ? AND ? OR term = ?", date_begin, date_end +'%', '')}
  
end
