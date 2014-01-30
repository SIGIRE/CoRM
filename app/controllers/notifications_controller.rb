# encoding: utf-8
class NotificationsController < ApplicationController

  def index
		@emails = Email.where("user_id = ?", current_user.id)
		@accounts = Account.all
		@tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("statut ASC, priority DESC, term DESC").limit(5)
  end

end
