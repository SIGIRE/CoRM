class RemoveAttachementFieldsFromEmail < ActiveRecord::Migration
  def up
    # Suppression des champs devenus inutiles
    change_table :emails do |t|
        remove_attachment :emails, :attach
    end
    
    # Creation de la table regroupant les pieces-jointes des emails
    create_table :email_attachements do |t|
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
    
    # Recuperation des emails
    emails = Email.all
    
    # Suppression de la table "email_attachements"
    drop_table :email_attachements
    
  end
end
