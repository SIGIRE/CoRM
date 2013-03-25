##
# This class represents an event. The most of the time, this is an exchange 
# between two contacts  of two differents Business.
# So, an Event is defined by a Contact, an Account, an EventType, a User and a Task
#
class Event < ActiveRecord::Base
  belongs_to :contact
  belongs_to :account
  belongs_to :eventtypes
  belongs_to :user
  belongs_to :task
  
  paginates_per 10
  
  has_attached_file :attach
  
  
end
