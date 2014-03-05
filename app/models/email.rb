class Email < ActiveRecord::Base

attr_accessible :id, :content, :object, :send_at, :to, :user_id, :contact_id, :email_attachments, :email_attachments_attributes, :account_id
has_many :email_attachments, :dependent => :destroy
alias_attribute :attachments, :email_attachments
accepts_nested_attributes_for :email_attachments
paginates_per 10

def check
	if (!contact_id.blank?)
		contact = Contact.find(contact_id)
		if (!contact.account_id.blank?)
			if(!WebmailConnection.first.type_event_id.blank?)
				if (!(object + content).blank?)
					return true
				end
				return false
			end
			return false
		end
		return false
    elsif (!account_id.blank?)
        if(!WebmailConnection.first.type_event_id.blank?)
	        if (!(object + content).blank?)
		        return true
			end
			return false
		end
		return false
	end
	return false
end

def convert
    # Récupération du contact
    contact = nil
    account_id = self.account_id
    
    if (!contact_id.blank?)
        contact = Contact.find(contact_id)
        account_id = contact.account_id
	end
	
    # Création d'un évènement
    event = Event.new
    event.date_begin = send_at
    event.date_end = send_at
    event.notes = "Sujet : #{object} \n #{content}"
    event.created_by = user_id
    if (!contact.blank?)
        event.contact_id = contact_id
    end
    event.account_id = account_id
    event.event_type_id = WebmailConnection.first.type_event_id
    event.user_id = user_id
    email_attachments.each do |attachment|
        attach = EventAttachment.new
        attach.attach = attachment.attach
        event.event_attachments.push attach
    end
    event.save
    destroy
end
end
