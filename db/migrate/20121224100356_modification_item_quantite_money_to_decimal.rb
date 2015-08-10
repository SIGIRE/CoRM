class ModificationItemQuantiteMoneyToDecimal < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.remove :quantite_cents
      t.remove :quantite_currency
      t.decimal :quantite
    end

  end

end
