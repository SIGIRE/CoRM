class CreateDevis < ActiveRecord::Migration
  def change
    create_table :devis do |t|

      t.string :ref
      t.timestamp :date
      t.string :statut
      t.string :ref_compte
      t.string :mode_reg
      t.integer :validite
      t.float :tva
      t.boolean :done
      t.float :total_ht
      t.float :total_tva
      t.float :total_ttc

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
      t.references :opportunite


    end
  end
end
