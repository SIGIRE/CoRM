class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|

      t.timestamps
    end
  end
end
