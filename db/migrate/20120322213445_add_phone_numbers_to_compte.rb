class AddPhoneNumbersToCompte < ActiveRecord::Migration
  def change
    add_column :comptes, :tel, :string

    add_column :comptes, :fax, :string

    add_column :comptes, :email, :string

    add_column :comptes, :web, :string

  end
end
