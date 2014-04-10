##
# This class represents an event. The most of the time, this is an exchange 
# between two contacts  of two differents Business.
# So, an Event is defined by a Contact, an Account, an EventType, a User and a Task
#
class Event < ActiveRecord::Base

  resourcify

  belongs_to :contact
  belongs_to :account
  belongs_to :event_type
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :task
  
  paginates_per 10
  
  # Conservé pour le bon fonctionnement des migrations --> non utilisé
  has_attached_file :attach
  
  # Nouvelle gestion des pièces-jointes
  has_many :event_attachments, :dependent => :destroy
  accepts_nested_attributes_for :event_attachments
  alias_attribute :attachments, :event_attachments
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end

  scope :by_account_id, lambda { |account_id| where("events.account_id = ?", account_id) }
  scope :by_event_type_id, lambda { |event_type_id| where("events.event_type_id = ?", event_type_id) }
  scope :by_contact_id, lambda { |contact_id| where("events.contact_id = ?", contact_id) }
  scope :by_user_id, lambda { |user_id| where("events.user_id = ?", user_id) }
  scope :by_content_like, lambda { |content| where("UPPER(events.notes) LIKE UPPER(?) or UPPER(events.notes2) LIKE UPPER(?)", "%#{content}%", "%#{content}%") }
end
