class AddImportIdColumnInAccounts < ActiveRecord::Migration
  def up
    add_column :accounts, :import_id, :integer
  end

  def down
    remove_column :accounts, :import_id
  end
end
