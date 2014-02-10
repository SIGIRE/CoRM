class Email < ActiveRecord::Base

attr_accessible :attach, :id, :attach_content_type, :attach_file_name, :attach_file_size, :content, :object, :send_at, :to, :user_id, :contact_id

has_attached_file :attach

def check
	if (!contact_id.nil?)
		contact = Contact.find(contact_id)
		if (!contact.account_id.nil?)
			if(!WebmailConnection.first.type_event_id.nil?)
				if (!(object + content).nil?)
					return true
				end
				return false
			end
			return false
		end
		return false
	end
	return false
end
end
