class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :nom

      t.timestamps

      t.references :compte1
      t.references :compte2
    end
  end
end
