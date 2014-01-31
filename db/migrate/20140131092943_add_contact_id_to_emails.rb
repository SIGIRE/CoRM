class AddContactIdToEmails < ActiveRecord::Migration
  def change
		add_column :email, :contact_id, :integer
  end
end
