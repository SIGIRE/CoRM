class AddActiveColumnToAccounts < ActiveRecord::Migration
  # Declare a local Model to handle conflicts with future migrations
  class Account < ActiveRecord::Base
  end  
  def change
    add_column :accounts, :active, :boolean, default: true
    Account.update_all active: true
  end
end
