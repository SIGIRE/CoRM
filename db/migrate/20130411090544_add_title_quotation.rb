class AddTitleQuotation < ActiveRecord::Migration
   def change
          add_column(:quotations, :label, :string)
   end
end

