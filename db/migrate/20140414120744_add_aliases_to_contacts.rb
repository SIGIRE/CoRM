class AddAliasesToContacts < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.integer :contact_id
      t.string :email
    end
  end
end
