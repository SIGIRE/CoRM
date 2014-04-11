class RationaliseEmails < ActiveRecord::Migration
  def change
    add_column :emails, :from, :text
    add_column :emails, :cc, :text
    add_column :emails, :cci, :text
    add_column :emails, :subject, :text

    remove_column :emails, :contact_id
    remove_column :emails, :account_id
  end
end
