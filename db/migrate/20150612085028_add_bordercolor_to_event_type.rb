class AddBordercolorToEventType < ActiveRecord::Migration
  def change
    add_column :event_types, :bordercoler, :string
  end
end
