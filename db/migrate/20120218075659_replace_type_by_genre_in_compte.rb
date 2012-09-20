class ReplaceTypeByGenreInCompte < ActiveRecord::Migration
  def up
    remove_column :comptes, :type
    add_column :comptes, :genre, :string    
  end

  def down
    add_column :comptes, :type, :string
    remove_column :comptes, :genre    
  end
end
