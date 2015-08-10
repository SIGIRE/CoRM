class CreateTaches < ActiveRecord::Migration
  def change
    create_table :taches do |t|
      t.timestamp :echeance
      t.text :notes
      t.string :statut
      t.timestamp :created_at
      t.string :created_by
      t.timestamp :modified_at
      t.string :modified_by

      t.timestamps

      t.references :contact
      t.references :compte
      t.references :user
    end
  end
end
