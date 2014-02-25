class RemoveAttachementFieldsFromEmail < ActiveRecord::Migration
  def up
    # Suppression des champs devenus inutiles
    change_table :emails do |t|
        if !column_exists? :emails, :attach_updated_at
            add_column :emails, :attach_updated_at, :datetime
        end
        remove_attachment :emails, :attach
	end

    
    # Creation de la table regroupant les pieces-jointes des emails
    create_table :email_attachments do |t|
        t.integer :email_id
        t.attachment :attach
        t.timestamps
    end
  end

  def down
    # Modification de la table 'emails'
    
    change_table :emails do |t|
        t.attachment :attach
    end
    
    # Suppression de la table "email_attachments"
    drop_table :email_attachments
    
  end
end
