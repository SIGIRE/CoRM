class DocumentAttachment < ActiveRecord::Base
    attr_accessible :document_id, :attach
    belongs_to :document
    has_attached_file :attach
end
