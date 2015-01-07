class DeleteCategoryColumnInImports < ActiveRecord::Migration
  def up
    remove_column :imports, :category
  end

  def down
    add_column :imports, :category, :string
  end
end
