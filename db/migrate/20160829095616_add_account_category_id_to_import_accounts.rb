class AddAccountCategoryIdToImportAccounts < ActiveRecord::Migration
  def up
    add_column :import_accounts, :account_category_id, :integer
  end

  def down
    remove_column :import_accounts, :account_category_id
  end
end
