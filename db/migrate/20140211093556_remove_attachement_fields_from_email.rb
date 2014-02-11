class RemoveAttachementFieldsFromEmail < ActiveRecord::Migration
  def up
    # Recuperation des emails avec pieces-jointes
    emails = Email.where(:attach_file_name => !blank?)
    
    # Suppression des champs devenus inutiles
    change_table :emails do |t|
        t.remove :attach_file_name, :attach_content_type, :attach_file_size 
    end
    
    # Creation de la table regroupant les pieces-jointes des emails
    create_table :emails_attachements do |t|
        t.integer :email_id
        t.string :attach_file_name, :attach_content_type
        t.integer :attach_file_size 
        t.timestamps
    end
    
  end

  def down
    # Recuperation des emails avec pieces-jointes
    emails = Email.all
    
    drop_table :emails_attachements
    
    change_table :emails do |t|
        t.string :attach_file_name, :attach_content_type
        t.integer :attach_file_size
    end
    
    emails.each do |email|
        if (!email.email_attachements.blank?)
            attachements = EmailsAttachements.where(:email_id => email.id)
            attachements.each do |attachement|
            end
        end
    end
  end
end
