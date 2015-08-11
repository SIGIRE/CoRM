class AddPeriodicityBillingToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :periodicity_billing, :string
  end
end
