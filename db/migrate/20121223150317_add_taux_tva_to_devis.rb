class AddTauxTvaToDevis < ActiveRecord::Migration
  def change
    change_table :devis do |t|
      t.remove :taux_tva_cents
      t.decimal :taux_tva
    end
  end
end
