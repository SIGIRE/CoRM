##
# This class represents an Event type as: outgoing call or incoming call.
# it is defined by an action (call) and a direction (incoming, outgoing)
#
class EventType < ActiveRecord::Base
  has_many :events
  
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
    
  scope :by_name, lambda { |name| where("label LIKE ?", name+'%') }
  
end
