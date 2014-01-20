class Emails < ActiveRecord::Base
  attr_accessible :account_id, :attach_content_type, :attach_file_name, :attach_file_size, :content, :object, :send_at, :to, :user_id
end
