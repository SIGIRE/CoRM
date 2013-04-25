class AddTotalTvaToDevis < ActiveRecord::Migration
  def change
    change_table :devis do |t|
      t.remove :taux_tva_currency
      t.money :total_tva
    end     
  end
end
