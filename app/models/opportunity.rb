# encoding: utf-8

##
# This class represents an opportunity and it defined by a Contact, a Business and a User Account
# It can have different status as Detected, In progress, Won or Lose
#
class Opportunity < ActiveRecord::Base
  
  belongs_to :contact
  belongs_to :account
  belongs_to :user
  
  paginates_per 10
  
  STATUTS = ["Détectée", "En cours", "Gagnée", "Perdue"]
  validates_inclusion_of :statut, :in => STATUTS
  
  has_attached_file :attach
  
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_user, lambda { |user| where( "user_id = ?", user) unless user.blank? }
  scope :by_term, lambda { |date_begin,date_end|  where( "term BETWEEN ? AND ? OR term IS NULL", '%'+date_begin, date_end+'%')}
  
end
