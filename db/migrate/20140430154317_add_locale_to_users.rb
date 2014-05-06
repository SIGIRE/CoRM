class AddLocaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locale, "varchar(2)"
  end
end
