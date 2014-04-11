class ChangeTextFormatInEmails < ActiveRecord::Migration
  def change
    change_column :emails, :to, :text
  end
end
