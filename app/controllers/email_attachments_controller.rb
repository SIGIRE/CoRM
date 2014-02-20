# encoding: utf-8

class EmailAttachmentsController < ApplicationController

  def destroy
  		@attach = EmailAttachment.find(params[:id])
		@email = @attach.email_id
		@attach.destroy
		redirect_to edit_email_path(@email), :notice => "Pièce jointe supprimée."
  end

end
