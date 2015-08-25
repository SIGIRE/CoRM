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
  belongs_to :event_type
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  has_many :task_attachments, :dependent => :destroy
  has_many :events

  accepts_nested_attributes_for :task_attachments, allow_destroy: true
  alias_attribute :attachments, :task_attachments
  paginates_per 10


  # Validation using global Settings
  # don't use validates_associated : it does not work ;)
  validates :account, :presence => true, if: :mandatory_account_setting?
  validates :contact, :presence => true, if: :mandatory_contact_setting?

  def mandatory_account_setting?
    @setting = Setting.all.first
    @setting.mandatory_account
  end

  def mandatory_contact_setting?
    @setting = Setting.all.first
    @setting.mandatory_contact
  end

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

  validates_inclusion_of :priority, :in => 0..PRIORITIES.length

  # Conservé pour le bon fonctionnement des migrations --> non utilisé
  has_attached_file :attach

  Paperclip.interpolates :with_content_type do |attachment, style|
    "#{attachment.instance.with_content_type}"
  end

  scope :by_priority, lambda { |priority| where("priority = ?", priority) unless priority.blank? }
  scope :by_statut, lambda { |statut| where("statut = ?", statut) unless statut.blank? }
  scope :undone, lambda { where("statut IN ('A faire', 'En cours')") }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_account_id, lambda { |account_id| where("account_id = ?", account_id) unless account_id.blank?}
  scope :by_account_company_like, (lambda do |account_company|
    unless account_company.blank?
      joins(:account).
      where("UPPER(accounts.company) LIKE UPPER(?)", account_company + '%')
    end
  end)
  scope :by_contact, lambda { |contact| where("contact_id = ?", contact.id) unless contact.nil? }
  scope :by_contact_id, lambda { |contact_id| where("contact_id = ?", contact_id) unless contact_id.blank? }
  scope :by_user, lambda { |user| where("tasks.user_id = ?", user.id) unless user.nil? }
  scope :by_user_id, lambda { |user_id| where("tasks.user_id = ?", user_id) unless user_id.blank? }
  scope :by_author_user_id, lambda { |author_user_id| where( "tasks.created_by = ?", author_user_id) unless author_user_id.blank? }
  #scope :by_term, lambda { |date_begin,date_end| where("term BETWEEN ? AND ? OR term = ?", date_begin, date_end +'%', '')}
  scope :none, lambda { where('1 = 0') }
  scope :by_notes_like, lambda { |notes| where("UPPER(tasks.notes) LIKE UPPER(?)", "%#{notes}%") unless notes.blank? }
  scope :between_dates, lambda { |start_at, end_at| where("created_at >= ? AND created_at <= ?", start_at, end_at) }

end
