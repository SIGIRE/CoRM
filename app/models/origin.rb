##
# This class represents an Origin.
# It can contains name and a description
# It can be, for example, name: 'at a fair' description: 'Met this person at the pudding fair'
#
class Origin < ActiveRecord::Base

  has_many :account
  paginates_per 10
end
