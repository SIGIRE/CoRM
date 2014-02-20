class CreateQuotationAttachments < ActiveRecord::Migration
  def up
    # Creation de la table regroupant les pieces-jointes des quotations
    create_table :quotation_attachments do |t|
        t.integer :quotation_id
        t.attachment :attach
        t.timestamps
    end
  end
  
  def down
    # Suppression de la table "quotation_attachments"
    drop_table :quotation_attachments
  end
end
