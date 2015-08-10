class CreateContracts < ActiveRecord::Migration

  def self.up
    create_table :contracts do |t|
      t.string :name
      t.text :description
      t.string :created_by
      t.string :updated_by
      t.date :date_begin
      t.date :date_end
      t.date :date_initial
      t.timestamps
      t.integer :account_id
      t.integer :contract_category_id
    end
  end

  def self.down
     drop_table :contracts
  end

end
