##
# This class represents a template to use with a Quotation
# It can contains a file
#
class QuotationTemplate < ActiveRecord::Base

  has_many :quotation
  has_attached_file :attach
  
  paginates_per 10
  
end
