class CreateImportContacts < ActiveRecord::Migration
  def change
    create_table :import_contacts do |t|
      t.string :surname
      t.string :forename
      t.string :title
      t.string :tel
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :job
      t.text :notes
      t.integer :created_by
      t.integer :modified_by
      t.integer :account_id
      t.boolean :active, :default => true
      t.integer :import_id
      t.string :anomaly
      t.timestamps
      t.references :compte
    end
  end
end
