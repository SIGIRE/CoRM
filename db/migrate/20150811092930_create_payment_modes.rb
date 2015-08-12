class CreatePaymentModes < ActiveRecord::Migration
  def up
    create_table :payment_modes do |t|
      t.string :name, null: false
      t.string :created_by
      t.string :modified_by
      t.timestamps
    end
  end

  def down
    drop_table :payment_modes
  end
end
