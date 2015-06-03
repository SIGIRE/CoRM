class CreateContractAttachments < ActiveRecord::Migration
  def up
    # Creation de la table regroupant les documents des contrats
    create_table :contract_attachments do |t|
        t.integer :contract_id
        t.attachment :attach
        t.timestamps
    end    
  end

  def down
    # Suppression de la table "contract_attachments"
    drop_table :contract_attachments    
  end
end
