class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.string :nom
      t.text :description
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
