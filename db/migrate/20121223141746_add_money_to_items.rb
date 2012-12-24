class AddMoneyToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.remove :quantite, :prix_ht, :total_ht
      t.money :prix_ht
      t.money :total_ht
      t.decimal :quantite
    end        
  end
end
