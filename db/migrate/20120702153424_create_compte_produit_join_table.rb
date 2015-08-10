class CreateCompteProduitJoinTable < ActiveRecord::Migration
  def self.up
    create_table :comptes_produits, :id => false do |t|
      t.integer :compte_id
      t.integer :produit_id
    end
  end

  def self.down
    drop_table :comptes_produits
  end
end
