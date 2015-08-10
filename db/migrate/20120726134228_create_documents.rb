class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :nom
      t.text :notes
      t.has_attached_file :fichier_joint
      t.string :created_by
      t.string :updated_by

      t.timestamps

      t.references :compte
    end
  end
end
