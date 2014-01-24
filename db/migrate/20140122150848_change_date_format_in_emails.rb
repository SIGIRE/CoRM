class ChangeDateFormatInEmails < ActiveRecord::Migration
  def up
	change_column :emails, :send_at, :datetime
  end
  def down
	change_column :emails, :send_at, :date
  end
end
