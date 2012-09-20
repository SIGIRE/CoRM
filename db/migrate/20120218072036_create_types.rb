class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :libelle
      t.string :direction
      t.string :created_by
      t.string :modified_by

      t.timestamps
    end
  end
end
