class ModifyImportTable < ActiveRecord::Migration
  def change
    remove_column :imports, :origine_id
    add_column :imports, :type, :string
    add_column :imports, :note, :string
    add_column :imports, :name, :string
  end

end
