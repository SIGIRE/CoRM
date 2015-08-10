class RemoveAttachmentFieldsFromQuotation < ActiveRecord::Migration
  def up
    # Récupération des quotation
    quotations = Quotation.all
    quotations.each do |quotation|
        if (!quotation.attach.blank?)
            attach = QuotationAttachment.new
            attach.attach = quotation.attach
            quotation.quotation_attachments.push attach
        end
    end

    # Suppression des champs devenus inutiles
    change_table :quotations do |t|
        remove_attachment :quotations, :attach
    end
  end

  def down
    # Modification de la table 'quotations'
    change_table :quotations do |t|
        t.attachment :attach
    end

    # Recuperation des évènements
    quotations = Quotation.all
    quotations.each do |quotation|
        if (!quotation.quotation_attachments.blank?)
            quotation.quotation_attachments.each do |attachment|
                new_quotation = quotation.dup
                new_quotation.attach = attachment.attach
                new_quotation.save
            end
            quotation.destroy
        end
    end
  end
end
