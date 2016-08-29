class UpdateCategoryAccountIdOfImportAccounts < ActiveRecord::Migration
  def change
    ImportAccount.all.each do |import_account|
      account_category = AccountCategory.where(:name => import_account.category).first
      import_account.account_category_id = account_category.id
      import_account.save!
    end
  end
end
