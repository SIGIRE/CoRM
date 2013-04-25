class AddEnablationToUser < ActiveRecord::Migration
  def change
    add_column(:users, :enabled, :boolean, { :default => FALSE })
    remove_column(:users, :is_admin)
    remove_column(:users, :is_super_user)
  end
end
