class CreateComptes < ActiveRecord::Migration
  def change
    create_table :comptes do |t|
      t.string :societe
      t.string :adresse1
      t.string :adresse2
      t.string :cp
      t.string :ville
      t.string :pays
      t.string :origine
      t.string :type
      t.string :code_compta
      t.text :notes
      t.string :created_by
      t.string :modified_by

      t.timestamps

      t.references :user
    end
  end
end
