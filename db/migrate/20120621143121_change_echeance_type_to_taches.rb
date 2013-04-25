class ChangeEcheanceTypeToTaches < ActiveRecord::Migration
  def up
    remove_column :taches, :echeance
    add_column :taches, :echeance, :string   
  end

  def down
    remove_column :taches, :echeance
    add_column :taches, :echeance, :timestamp
  end
end
