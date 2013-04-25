class CreateOrigines < ActiveRecord::Migration
  def change
    create_table :origines do |t|
		t.string :nom
      t.text :description

		t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
