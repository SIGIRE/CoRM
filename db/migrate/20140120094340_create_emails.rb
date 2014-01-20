class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :user_id
      t.string :to
      t.integer :account_id
      t.string :object
      t.text :content
      t.string :attach_file_name
      t.string :attach_content_type
      t.integer :attach_file_size
      t.date :send_at

      t.timestamps
    end
  end
end
