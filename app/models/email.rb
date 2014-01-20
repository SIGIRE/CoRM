class Email < ActiveRecord::Base
  attr_accessible :attach_content_type, :attach_file_name, :attach_file_size, :content, :object, :send_at, :to, :user_id
end
