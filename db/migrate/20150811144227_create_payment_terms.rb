class CreatePaymentTerms < ActiveRecord::Migration
  def up
    create_table :payment_terms do |t|
      t.string :name, null: false
      t.integer :days_number
      t.string :term_type
      t.integer :term_day
      t.integer :payment_mode_id
      t.string :created_by
      t.string :modified_by
      t.timestamps
    end
  end

  def down
    drop_table :payment_terms
  end
end
