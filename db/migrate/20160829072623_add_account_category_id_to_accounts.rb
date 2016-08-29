class AddAccountCategoryIdToAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :account_category_id, :integer
  end

  def down
    remove_column :accounts, :account_category_id
  end
end
