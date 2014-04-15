class RationalizeEmailClassSecondEdition < ActiveRecord::Migration
  def change
    add_column :emails, :contact_id, :integer
    add_column :emails, :account_id, :integer

    remove_column :emails, :subject
  end
end
