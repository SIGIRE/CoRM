class RemoveCategoryOfAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :category
  end

  def down
    add_column :accounts, :category, :string
    Account.all.each do |account|
      account_category = AccountCategory.find(account.account_category_id)
      account.category = account_category.name
      account.save!
    end
  end
end
