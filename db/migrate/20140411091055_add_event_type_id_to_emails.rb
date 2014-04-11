class AddEventTypeIdToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :event_type_id, :integer
  end
end
