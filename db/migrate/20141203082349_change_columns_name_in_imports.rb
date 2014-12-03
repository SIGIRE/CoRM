class ChangeColumnsNameInImports < ActiveRecord::Migration
  def up
    rename_column :imports, :categorie, :category
    rename_column :imports, :note, :notes
  end

  def down
    rename_column :imports, :category, :categorie
    rename_column :imports, :notes, :note
  end
end
