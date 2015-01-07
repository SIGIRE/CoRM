class AddImportIdColumnInContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :import_id, :integer
  end

  def down
    remove_column :contacts, :import_id
  end
end
