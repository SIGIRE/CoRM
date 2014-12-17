class AddColumnSearchDuplicates < ActiveRecord::Migration
  def up
    add_column :import_contacts, :search_duplicates, :boolean, :default=>true
    add_column :import_accounts, :search_duplicates, :boolean, :default=>true
  end


end
