class AddMandatoryAccountAndContactToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :mandatory_account, :boolean, default: false
    add_column :settings, :mandatory_contact, :boolean, default: false
  end
end
