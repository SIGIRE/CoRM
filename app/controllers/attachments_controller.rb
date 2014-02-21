# encoding: utf-8

class AttachmentsController < ApplicationController

# On utilise ce controleur pour supprimer des pièces jointes dans une des tables, on utilise "type" pour savoir dans quelle table supprimer la PJ

  def destroy
		type = params[:type]
		case type
			when "email"
		  		@attach = EmailAttachment.find(params[:id])
				@email = @attach.email_id
				@attach.destroy
				redirect_to edit_email_path(@email), :notice => "Pièce jointe supprimée."
			when "task"
				@attach = TaskAttachment.find(params[:id])
				@task = @attach.task_id
				@attach.destroy
				redirect_to edit_task_path(@task), :notice => "Pièce jointe supprimée."
			when "document"
				@attach = DocumentAttachment.find(params[:id])
				@document = @attach.document_id
				@attach.destroy
				redirect_to edit_document_path(@document), :notice => "Pièce jointe supprimée."
			when "opportunity"
				@attach = OpportunityAttachment.find(params[:id])
				@opportunity = @attach.opportunity_id
				@attach.destroy
				redirect_to edit_opportunity_path(@opportunity), :notice => "Pièce jointe supprimée."
			when "quotation"
				@attach = QuotationAttachment.find(params[:id])
				@quotation = @attach.quotation_id
				@attach.destroy
				redirect_to edit_quotation_path(@quotation), :notice => "Pièce jointe supprimée."
			else
				redirect_to home_path, :notice => "Une erreur s'est produite."
		end
  end
end
