##
# This class represents a relation between two Companies.
#
class Relation < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :account1, :class_name => 'Account'
  belongs_to :account2, :class_name => 'Account'
  
  scope :by_account, lambda { |account| where("account1_id = ? OR account1_id = ?", account.id, account.id) unless account.nil? }
end
