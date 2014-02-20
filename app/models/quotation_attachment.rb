class QuotationAttachment < ActiveRecord::Base
    attr_accessible :quotation_id, :attach
    belongs_to :quotation
    has_attached_file :attach
end
