class CreateTaskAttachments < ActiveRecord::Migration
  def up
    # Creation de la table regroupant les pieces-jointes des emails
    create_table :task_attachments do |t|
        t.integer :task_id
        t.attachment :attach
        t.timestamps
    end
  end
  
  def down
    # Suppression de la table "event_attachments"
    drop_table :task_attachments
  end
end
