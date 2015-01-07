class ChangeTableImportContacts < ActiveRecord::Migration
  def change
    remove_column :import_contacts, :anomaly
    add_column :import_contacts, :anomaly_id, :integer
    add_column :import_contacts, :contact_id, :integer
  end
end
