class CreateImportAccounts < ActiveRecord::Migration
  def change
    create_table :import_accounts do |t|
      
    t.string :company
    t.string :adress1
    t.string :adress2
    t.string :zip
    t.string :city
    t.string :country
    t.string :accounting_code
    t.text :notes
    t.integer :created_by
    t.integer :modified_by
    t.integer :user_id
    t.string :category
    t.string :tel
    t.string :fax
    t.string :email
    t.string :web
    t.integer :origin_id
    t.boolean :active, :default => true
    t.integer :import_id
    t.boolean :valid, :default => true
    t.timestamps
    t.references :user
    end
  end
end
