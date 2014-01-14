class AddRateToQuotationTemplates < ActiveRecord::Migration
  def change
	add_column :quotation_templates, :vat_rate, :float
  end
end
