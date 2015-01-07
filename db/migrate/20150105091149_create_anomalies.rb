class CreateAnomalies < ActiveRecord::Migration
  def change
    create_table :anomalies do |t|
      t.string :name
      t.string :notes
      t.integer :level

      t.timestamps
    end
  end
end
