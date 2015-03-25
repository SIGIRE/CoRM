class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :created_by
      t.string :updated_by
      t.timestamps    
    end
  end
end
