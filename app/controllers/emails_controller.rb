# encoding: utf-8

class EmailsController < ApplicationController


  ##
  # Render the page to edit one email
  #
  def edit
	@email = Email.find(params[:id])
  end

  def index
	@emails = Email.where("user_id = ?", current_user.id)
  end

  def destroy
	@email = Email.find_by_id(params[:id])
	@email.destroy
	redirect_to emails_url, :notice => "L'email a été supprimé."
  end
end
