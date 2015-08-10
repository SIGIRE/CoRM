class CreateEvenements < ActiveRecord::Migration
  def change
    create_table :evenements do |t|
      t.timestamp :debut
      t.timestamp :fin
      t.text :notes
      t.string :created_by
      t.string :modified_by

      t.timestamps

      t.references :contact
      t.references :compte
      t.references :type
      t.references :user
    end
  end
end
