#encoding: utf-8

class AccountCategory < ActiveRecord::Base
  resourcify

  validates :name, uniqueness: true

  has_many :accounts
  has_many :import_accounts

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
