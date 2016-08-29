class AddDefaultAccountCategoryIdToSettings < ActiveRecord::Migration
  def up
    add_column :settings, :default_account_category_id, :integer
    setting = Setting.first
    if !setting.nil?
      account_category = AccountCategory.where(:name => 'Client').first
      if !account_category.nil?
        setting.default_account_category_id = account_category.id
        setting.save
      end
    end
  end

  def down
    remove_column :settings, :default_account_category_id
  end
end
