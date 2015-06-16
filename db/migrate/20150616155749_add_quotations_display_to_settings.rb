class AddQuotationsDisplayToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :quotations_display, :boolean, default: true
  end
end
