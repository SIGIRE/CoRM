class AddAtBeginningToMailEventType < ActiveRecord::Migration
  def up
    add_column :mail_event_types, :at_beginning, :boolean, :default => true
  end

  def down
    remove_column :mail_event_types, :at_beginning
  end
end
