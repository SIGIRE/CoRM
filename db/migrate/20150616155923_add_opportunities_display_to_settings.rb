class AddOpportunitiesDisplayToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :opportunities_display, :boolean, default: true    
  end
end
