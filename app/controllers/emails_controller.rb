class EmailsController < ApplicationController


  ##
  # Render the page to edit one email
  #
  def edit
	@email = Email.find(params[:id])
  end

  def index
	@emails = Email.where("user_id = ?", current_user.id)
	@accounts = Account.all
  end
end
