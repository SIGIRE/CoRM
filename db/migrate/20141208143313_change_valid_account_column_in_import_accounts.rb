class ChangeValidAccountColumnInImportAccounts < ActiveRecord::Migration
  def up
    rename_column :import_accounts, :valid_account, :anomaly
    change_column :import_accounts, :anomaly, :string
    change_column_default :import_accounts, :anomaly, '-'
  end

  def down
    change_column :import_accounts, :anomaly, :boolean
    change_column_default :import_accounts, :anomaly, true
    rename_column :import_accounts, :anomaly, :valid_account
  end
end
