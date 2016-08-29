class UpdateCategoryAccountIdOfAccounts < ActiveRecord::Migration
  def change
    Account.all.each do |account|
      account_category = AccountCategory.where(:name => account.category).first
      account.account_category_id = account_category.id
      account.save!
    end
  end
end
