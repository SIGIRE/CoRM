class ContractAttachment < ActiveRecord::Base
    attr_accessible :contract_id, :attach
    belongs_to :contract
    has_attached_file :attach
end
