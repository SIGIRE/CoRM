class DeleteAllUnecessary < ActiveRecord::Migration
  def up
    drop_table(:admin_notes)
    drop_table(:admin_users)
    drop_table(:ckeditor_assets)
    drop_table(:abilities)
  end
end
