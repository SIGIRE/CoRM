class ChangeCompanyType < ActiveRecord::Migration
  def up
    change_column :import_contacts, :company, :string
  end

  def down
    change_column :import_contacts, :company, :integer
  end
end
