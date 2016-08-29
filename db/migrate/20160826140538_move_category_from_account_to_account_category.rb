class MoveCategoryFromAccountToAccountCategory < ActiveRecord::Migration
  def change
    Account.uniq.pluck(:category).each do |category|
      account_category = AccountCategory.new
      account_category.name = category
      account_category.save!
    end
  end
end
