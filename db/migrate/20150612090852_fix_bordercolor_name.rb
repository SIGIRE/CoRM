class FixBordercolorName < ActiveRecord::Migration
  def change
    rename_column :event_types, :bordercoler, :bordercolor
  end
end
