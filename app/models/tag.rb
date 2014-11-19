##
# This class represents a product defined by a name and a description.
# It can have and belongs to many Account and Contacts
#
class Tag < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :contacts
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  paginates_per 10
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  #scope :by_account_with_contacts, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  #scope :by_account_tags, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
end
