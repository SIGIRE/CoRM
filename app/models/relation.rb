##
# This class represents a relation between two Companies.
#
class Relation < ActiveRecord::Base
  resourcify

  validates :account1, presence: true
  validates :account2, presence: true
  validates :name, presence: true

  belongs_to :account1, :class_name => 'Account'
  belongs_to :account2, :class_name => 'Account'
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'

  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end

  scope :by_account, lambda { |account| where("account1_id = ? OR account2_id = ?", account.id, account.id) unless account.nil? }
end
