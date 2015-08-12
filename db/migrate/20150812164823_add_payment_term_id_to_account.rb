class AddPaymentTermIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :payment_term_id, :integer
  end
end
