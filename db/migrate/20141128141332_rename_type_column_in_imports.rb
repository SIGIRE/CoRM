class RenameTypeColumnInImports < ActiveRecord::Migration
  def change
    rename_column :imports, :type, :import_type
  end

end
