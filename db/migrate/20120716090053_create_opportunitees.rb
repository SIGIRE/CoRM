class CreateOpportunitees < ActiveRecord::Migration
  def change
    create_table :opportunitees do |t|
      t.string :nom
      t.text :description
      t.string :statut
      t.string :remarque
      t.float :montant
      t.timestamp :echeance
      
      t.string :fichier_joint_file_name 
      t.string :fichier_joint_content_type 
      t.integer :fichier_joint_file_size
      t.datetime :fichier_joint_updated_at
      
      t.string :created_by
      t.string :updated_by
      t.timestamps
      
      t.references :compte
      t.references :contact
      t.references :user
    end
  end
end

