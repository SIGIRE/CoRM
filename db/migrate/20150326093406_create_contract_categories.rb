class CreateContractCategories < ActiveRecord::Migration

  def self.up
    create_table :contract_categories do |t|
      t.string :name
      t.text :description
      t.string :created_by
      t.string :updated_by
      t.timestamps
    end
  end

  def self.down
     drop_table :contract_categories
  end
end
