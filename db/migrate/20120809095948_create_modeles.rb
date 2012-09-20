class CreateModeles < ActiveRecord::Migration
  def change
    create_table :modeles do |t|

      t.string :societe
      t.string :adresse
      t.string :ville
      t.integer :cp
      t.string :pays
      t.string :tel
      t.string :fax
      t.string :site
      t.string :email
      t.string :capital
      t.string :ape
      t.string :siret
      t.string :tva
      
      t.string :fichier_joint_file_name 
      t.string :fichier_joint_content_type 
      t.integer :fichier_joint_file_size
      t.datetime :fichier_joint_updated_at
      
      t.timestamps
    end
  end
end
