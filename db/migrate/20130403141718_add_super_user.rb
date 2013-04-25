class AddSuperUser < ActiveRecord::Migration
  def change
    add_column(:users, :is_admin, :boolean, :default => false)
    add_column(:users, :is_super_user, :boolean, :default => false)
  end
end
