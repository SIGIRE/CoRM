class AddDefaultEventTypeToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :default_event_type_id, :integer
  end
end
