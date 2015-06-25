class CreateCampaignLines < ActiveRecord::Migration
  def up
    create_table :campaign_lines do |t|
      t.timestamp :last_action_date
      t.text :notes
      t.string :created_by
      t.string :modified_by
      t.integer :completed_percentage
      t.integer :result_percentage
      
      t.timestamps
      
      t.references :account
      t.references :contact
    end
  end

  def down
    drop_table :campaign_lines
  end
end
