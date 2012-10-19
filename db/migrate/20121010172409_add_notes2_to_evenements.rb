class AddNotes2ToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :notes2, :text
  end
end
