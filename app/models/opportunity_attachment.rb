class OpportunityAttachment < ActiveRecord::Base
    attr_accessible :opportunity_id, :attach
    belongs_to :opportunity
    has_attached_file :attach
end
