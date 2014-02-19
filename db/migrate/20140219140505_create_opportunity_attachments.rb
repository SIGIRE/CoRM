class CreateOpportunityAttachments < ActiveRecord::Migration
  def up
    # Creation de la table regroupant les pieces-jointes des opportunities
    create_table :opportunity_attachments do |t|
        t.integer :opportunity_id
        t.attachment :attach
        t.timestamps
    end
  end
  
  def down
    # Suppression de la table "opportunity_attachments"
    drop_table :opportunity_attachments
  end
end
