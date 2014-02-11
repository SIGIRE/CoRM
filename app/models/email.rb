class Email < ActiveRecord::Base

attr_accessible :id, :content, :object, :send_at, :to, :user_id, :contact_id, :email_attachements
has_many :email_attachements, :dependent => :destroy

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
