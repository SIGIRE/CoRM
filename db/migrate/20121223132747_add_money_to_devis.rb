class AddMoneyToDevis < ActiveRecord::Migration
  def change
    change_table :devis do |t|
      t.remove :tva, :total_ht, :total_tva, :total_ttc
      t.money :taux_tva
      t.money :total_ht
      t.money :total_ttc
      t.string :societe
      t.string :adresse1
      t.string :adresse2
      t.string :cp
      t.string :ville
      t.string :pays
      t.string :nom
      t.string :prenom
      t.string :civilite
      t.string :fonction
    end
  end
end
