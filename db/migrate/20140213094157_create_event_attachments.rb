class CreateEventAttachments < ActiveRecord::Migration
  def up
    # Creation de la table regroupant les pieces-jointes des emails
    create_table :event_attachments do |t|
        t.integer :event_id
        t.attachment :attach
        t.timestamps
    end
  end

  def down
    # Suppression de la table "event_attachments"
    drop_table :event_attachments
  end
end
