class ChangeTypeColumnInImports < ActiveRecord::Migration
  def rename
    rename_column :imports, :type, :import_type
  end

end
