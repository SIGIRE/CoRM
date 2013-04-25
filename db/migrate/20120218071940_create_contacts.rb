class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :nom
      t.string :prenom
      t.string :civilite
      t.string :tel
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :fonction
      t.text :notes
      t.string :created_by
      t.string :modified_by

      t.timestamps
      
      t.references :compte
    end
  end
end
