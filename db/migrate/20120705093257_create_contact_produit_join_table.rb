class CreateContactProduitJoinTable < ActiveRecord::Migration
  
  def self.up
    create_table :contacts_produits, :id => false do |t|
      t.integer :contact_id
      t.integer :produit_id
    end
  end

  def self.down
     drop_table :contacts_produits
  end
  
end
