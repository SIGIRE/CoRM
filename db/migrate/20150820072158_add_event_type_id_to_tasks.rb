class AddEventTypeIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :event_type_id, :integer
  end
end
