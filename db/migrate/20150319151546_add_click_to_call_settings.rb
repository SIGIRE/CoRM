class AddClickToCallSettings < ActiveRecord::Migration
  def change
    add_column :settings, :clicktocall, :boolean, default: false
  end
end
