##
# This class represents an Contract_category.
# It can contains name and a description
# It can be, for example, name: 'at a fair' description: 'Met this person at the pudding fair'
#
class ContractCategory < ActiveRecord::Base

  resourcify

  validates :name, uniqueness: true

  has_many :contracts
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'

  paginates_per 10

  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end
end