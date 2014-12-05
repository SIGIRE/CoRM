class ChangeNameColumnValid < ActiveRecord::Migration
  def up
    rename_column :import_accounts, :valid, :valid_account
  end

  def down
    rename_column :import_accounts, :valid_account, :valid
  end
end
