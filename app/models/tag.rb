##
# This class represents a product defined by a name and a description.
# It can have and belongs to many Account and Contacts
#
class Tag < ActiveRecord::Base
  
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :contacts
  
  paginates_per 10
  
  scope :by_account_with_contacts, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  
end
