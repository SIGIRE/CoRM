##
# This class represents an Event type as: outgoing call or incoming call.
# it is defined by an action (call) and a direction (incoming, outgoing)
#
class EventType < ActiveRecord::Base

  resourcify
  ### attr_accessible :id, :label, :direction, :bordercolor
  has_many :events, :dependent => :restrict
  has_many :tasks, :dependent => :restrict
  has_many :mail_event_types, :dependent => :restrict
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'

  paginates_per 10

  ##
  # Get the full Type
  # ( Label + Direction )
  # * *Returns*    :
  #   - The full type as  String
  #
  def full_type
    "#{label} #{direction}"
  end

  ##
  # Get the author of this EventType
  # if there is no author, return default user
  #
  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end

  scope :by_name, lambda { |name| where("label LIKE ?", name+'%') }

end
