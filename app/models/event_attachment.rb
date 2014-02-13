class EventAttachment < ActiveRecord::Base
  attr_accessible :event_id, :attach
  belongs_to :event
  has_attached_file :attach
end
