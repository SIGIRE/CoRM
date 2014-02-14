# encoding: utf-8

class EmailsController < ApplicationController


  ##
  # Render the page to edit one email
  #
  def edit
		@email = Email.find(params[:id])
  end

  def index
		@emails = Email.where("user_id = ?", current_user.id).order("id")
		@accounts = Account.all
  end

  def destroy
		@email = Email.find_by_id(params[:id])
		@email.destroy
		redirect_to notifications_url, :notice => "L'email a été supprimé."
  end

  def update
		@email = Email.find(params[:email][:id])
		@email.email_attachments.each do |attachment|
		    attach = EmailAttachment.new
		    attach.attach = attachment.attach
		end
		if @email.update_attributes(params[:email])
			redirect_to notifications_url, :notice => "L'email a été modifié."
		else
			redirect_to notifications_url
		end
  end

  def convert
        # Récupération de l'email
		@email = Email.find(params[:email])
		 
		# Récupération du contact
		@contact = Contact.find(@email.contact_id)
		
		# Création d'un évènement
		@event = Event.new
		@event.date_begin = @email.send_at
		@event.date_end = @email.send_at
		@event.notes = "Sujet : #{@email.object} \n #{@email.content}"
		@event.created_by = @email.user_id
		@event.contact_id = @email.contact_id
		@event.account_id = @contact.account_id
		@event.event_type_id = WebmailConnection.first.type_event_id
		@event.user_id = @email.user_id
		@email.email_attachments.each do |attachment|
		    attach = EventAttachment.new
		    attach.attach = attachment.attach
		    @event.event_attachments.push attach
		end
		@event.save
		@email.destroy
		redirect_to notifications_url, :notice => "L'email a été archivé."
	end
	
end
