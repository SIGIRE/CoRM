##
# This class represents a quotation line. It's defined by a reference, a designation, 
# a quantity and a Duty-Free Price
#
class QuotationLine < ActiveRecord::Base
  belongs_to :Quotation
  
  monetize :price_excl_tax_cents
  monetize :total_excl_tax_cents
  
  ##
  # Set the quantity
  # This method replace comas in the quantity by points (0,1 -> 0.1)
  #
  # * *Args*    :
  #   - +quantity+ -> Quantity to set (as String)
  #
  def quantite=(quantity)
    write_attribute(:quantity, quantity.gsub(',', '.'))
  end
  
end
