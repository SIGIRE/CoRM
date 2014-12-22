class AddColumnSearchDuplicates < ActiveRecord::Migration
  def up
    add_column :import_contacts, :no_search_duplicates, :boolean, :default=>false
    add_column :import_accounts, :no_search_duplicates, :boolean, :default=>false
  end
end
