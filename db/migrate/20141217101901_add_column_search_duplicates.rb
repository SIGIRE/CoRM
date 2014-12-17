class AddColumnSearchDuplicates < ActiveRecord::Migration
  def up
    add_column :import_contacts, :search_duplicates, :boolean, :default=>true
  end

  def down
    remove_column :import_contacts, :search_duplicates, :boolean
  end
end
