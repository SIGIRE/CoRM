class AddModeleToDevis < ActiveRecord::Migration
  def change
    add_column :devis, :modele_id, :integer
  end
end
