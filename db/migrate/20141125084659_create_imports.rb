class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :categorie
      t.string :created_by
      t.integer :origine_id
      t.timestamps
    end
  end
end
