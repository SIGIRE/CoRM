class RemoveCategoryOfImportAccounts < ActiveRecord::Migration
  def up
    remove_column :import_accounts, :category
  end

  def down
    add_column :import_accounts, :category, :string
    ImportAccount.all.each do |import_account|
      account_category = AccountCategory.find(import_account.account_category_id)
      import_account.category = account_category.name
      import_account.save!
    end
  end
end
