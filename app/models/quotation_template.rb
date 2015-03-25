##
# This class represents a template to use with a Quotation
# It can contains a file
#
class QuotationTemplate < ActiveRecord::Base
  resourcify
  has_many :quotation
  has_attached_file :attach

  validates :company, uniqueness: true  
  paginates_per 10
  
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  ##
  # Set the VAT
  # This method replace comas in the VAT rate by points (0,1 -> 0.1)
  #
  # * *Args*    :
  #   - +vat_rate+ -> Quantity to set (as float)
  #
  def vat_rate=(vat_rate)
    write_attribute(:vat_rate, vat_rate.gsub(',', '.'))
  end

  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
end
