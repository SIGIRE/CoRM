# encoding: utf-8
##
# This class represents a payment mode.
# It can contains a not null name.
# It can be, for example, name: 'Visa Card'
#
class PaymentMode < ActiveRecord::Base

  validates :name, uniqueness: true

  has_many :payment_terms, :dependent => :restrict
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
