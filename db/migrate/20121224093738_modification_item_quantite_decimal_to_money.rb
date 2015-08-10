class ModificationItemQuantiteDecimalToMoney < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.remove :quantite
      t.money :quantite
    end
  end

end
