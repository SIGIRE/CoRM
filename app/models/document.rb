##
# This class represents a readable file.
# It belongs to Account
#
class Document < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  belongs_to :author, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor, :foreign_key => 'updated_by', :class_name => 'User'
  
  paginates_per 10
  
  has_attached_file :attach
  
  validates_attachment_presence :attach
  validates :name,  :presence => true
  
  scope :by_account, lambda { |account| where("account_id = ?", account.id )unless account.nil? }
end
