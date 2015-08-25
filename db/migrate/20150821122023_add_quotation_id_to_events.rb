class AddQuotationIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :quotation_id, :integer
  end
end
