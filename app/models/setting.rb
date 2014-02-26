class Setting < ActiveRecord::Base
    has_attached_file :attach, :default_url => "/images/normal/logo-login.png"
    validates_attachment_content_type :attach, :content_type => /\Aimage\/.*\Z/
end
