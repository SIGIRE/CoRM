class RemoveAttachmentFieldsFromDocument < ActiveRecord::Migration
  def up
    # Récupération des document
    documents = Document.all
    documents.each do |document|
        if (!document.attach.blank?)
            attach = DocumentAttachment.new
            attach.attach = document.attach
            document.document_attachments.push attach
        end
    end
    
    # Suppression des champs devenus inutiles
    change_table :documents do |t|
        remove_attachment :documents, :attach
    end
  end

  def down
    # Modification de la table 'documents'
    change_table :documents do |t|
        t.attachment :attach
    end
    
    # Recuperation des évènements
    documents = Document.all
    documents.each do |document|
        if (!document.document_attachments.blank?)
            document.document_attachments.each do |attachment|
                new_document = document.dup
                new_document.attach = attachment.attach
                new_document.save
            end
            document.destroy
        end
    end
  end
end
