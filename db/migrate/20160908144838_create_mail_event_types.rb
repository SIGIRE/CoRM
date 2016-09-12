class CreateMailEventTypes < ActiveRecord::Migration
  def change
    create_table :mail_event_types do |t|
      t.string :name
      t.string :pattern
      t.references :event_type
      t.string :created_by
      t.string :updated_by
      
      t.timestamps
    end
    add_index :mail_event_types, :event_type_id
  end
end
