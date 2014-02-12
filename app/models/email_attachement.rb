class EmailAttachement < ActiveRecord::Base
  attr_accessible :email_id, :attach
  belongs_to :email
  has_attached_file :attach
end
