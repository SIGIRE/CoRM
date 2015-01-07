class ChangeAccountIdColumnInImportContacts < ActiveRecord::Migration
  def up
    rename_column :import_contacts, :compte_id, :company
  end

  def down
    rename_column :import_contacts, :company, :compte_id
  end
end
