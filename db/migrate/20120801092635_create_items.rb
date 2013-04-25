class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      
      t.string :ref
      t.text :designation
      t.float :quantite
      t.float :prix_ht
      t.float :total_ht
      t.timestamps
      
      t.references :devi
    end
  end
end
