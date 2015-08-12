# encoding: utf-8
##
# This class represents a payment term.
#
class PaymentTerm < ActiveRecord::Base

  validates :name, uniqueness: true

  belongs_to :payment_mode
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'

  paginates_per 10


  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end

end
