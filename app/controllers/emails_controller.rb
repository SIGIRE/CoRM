class EmailsController < ApplicationController
  def index
	@emails = Email.where("user_id = ?", current_user.id)
	@accounts = Account.all
  end
end
