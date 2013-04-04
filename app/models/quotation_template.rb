##
# This class represents a template to use with a Quotation
# It can contains a file
#
class QuotationTemplate < ActiveRecord::Base

  has_many :quotation
  has_attached_file :attach
  
  paginates_per 10
  
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
end
