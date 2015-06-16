class AddContractsDisplayToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :contracts_display, :boolean, default: true
  end
end
