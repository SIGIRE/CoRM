class AddLoginNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_name, :string
    User.update_all "login_name = email"
  end
end
