class AddTacheIdToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :tache_id, :integer

  end
end
