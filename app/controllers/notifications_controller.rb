# encoding: utf-8
class NotificationsController < ApplicationController

  def index
		@emails = Email.where("user_id = ?", current_user.id).limit(5).order("id")
		@tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("statut ASC, priority DESC, term DESC").limit(5)
		
		# On récupère les paramètres du serveur mail
	    if (WebmailConnection.all.length == 1)
		    @connection = WebmailConnection.first
		else 
			@connection = WebmailConnection.new
		end
  end

end
