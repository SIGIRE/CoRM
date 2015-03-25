class AddActivityToAccount < ActiveRecord::Migration
  def up
    add_column :accounts, :activity_id, :integer
  end

  def down
    remove_column :accounts, :activity_id
  end
end
