# encoding: utf-8

##
# This class represents an opportunity and it defined by a Contact, a Business and a User Account
# It can have different status as Detected, In progress, Won or Lose
#
class Opportunity < ActiveRecord::Base
  resourcify
  acts_as_xlsx
  
  validates_presence_of :name

  belongs_to :contact
  belongs_to :account
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  paginates_per 10
  
  STATUTS = ["Détectée", "En cours", "Gagnée", "Perdue", "Abandonnée","Suspendue"]
  validates_inclusion_of :statut, :in => STATUTS
  
    # Conservé pour le bon fonctionnement des migrations --> non utilisé
    has_attached_file :attach
      
    # Nouvelle gestion des pièces-jointes
    has_many :opportunity_attachments, :dependent => :destroy
    accepts_nested_attributes_for :opportunity_attachments, allow_destroy: true
    alias_attribute :attachments, :opportunity_attachments
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  def self.last_modified(how_many = 10)
    self.order('updated_at DESC, created_at DESC').limit(how_many)
  end

  # Convert commas in opportunity amount to dots
  def amount=(amount)
    write_attribute(:amount, amount.gsub(',', '.'))
  end

  # Convert commas in opportunity amount to dots
  def profit=(profit)
    write_attribute(:profit, profit.gsub(',', '.'))
  end
  
  
  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_account_id, lambda { |account_id| where("account_id = ?", account_id) unless account_id.blank? }
  scope :by_account_company_like, (lambda do |account_company|
    unless account_company.blank?
      joins(:account).
      where("UPPER(accounts.company) LIKE UPPER(?)", account_company + '%')
    end
  end)
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_contact_id, lambda { |contact_id| where("contact_id = ?", contact_id) unless contact_id.blank? }
  scope :by_user, lambda { |user| where( "opportunities.user_id = ?", user.id) unless user.nil? }
  scope :by_user_id, lambda { |user_id| where( "opportunities.user_id = ?", user_id) unless user_id.blank? }
  #scope :by_term, lambda { |date_begin,date_end|  where( "term BETWEEN ? AND ? OR term IS NULL", '%'+date_begin, date_end+'%')}
  scope :between_dates, lambda { |start_at, end_at| where("created_at >= ? AND created_at <= ?", start_at, end_at) }
  scope :by_origin_account, lambda { |origin_account| joins(:account).where("accounts.origin_id IN (?)", origin_account) unless origin_account.blank? } 
  scope :by_account_tags, lambda { |tags| joins(:account => :tags).where("tags.id IN (?)", tags) unless tags.blank? }
  scope :by_activity_account, lambda { |activity_account| joins(:account).where("accounts.activity_id IN (?)", activity_account) unless activity_account.blank? }
  scope :by_zip_account, lambda { |zip_account| joins(:account).where("accounts.zip LIKE ?", zip_account + '%') unless zip_account.blank? } 

  
end
