class ReplaceOrigineInCompte < ActiveRecord::Migration
  def up
    remove_column :comptes, :origine
    add_column :comptes, :origine_id, :integer
  end

  def down
    remove_column :comptes, :origine_id
    add_column :comptes, :origine, :string
  end
end
