##
# This class represents a readable file.
# It belongs to Account
#
class Document < ActiveRecord::Base
  
  belongs_to :account
  
  paginates_per 10
  
  has_attached_file :attach
  
  validates_attachment_presence :attach
  validates :name,  :presence => true
  
  scope :by_account, lambda { |account| where("account_id = ?", account.id )unless account.nil? }
end
