class ChangeTableImportAccounts < ActiveRecord::Migration
  def change
    remove_column :import_accounts, :anomaly
    add_column :import_accounts, :anomaly_id, :integer
    add_column :import_accounts, :account_id, :integer
  end
end
