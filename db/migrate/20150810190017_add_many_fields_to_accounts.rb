class AddManyFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :registration_number, :string
    add_column :accounts, :business_sector_code, :string
    add_column :accounts, :vat_number, :string
    add_column :accounts, :turnover, :integer
    add_column :accounts, :projected_turnover, :integer
    add_column :accounts, :identifier, :string
  end
end
