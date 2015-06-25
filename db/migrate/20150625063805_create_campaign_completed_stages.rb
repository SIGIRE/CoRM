class CreateCampaignCompletedStages < ActiveRecord::Migration
  def up
    create_table :campaign_completed_stages do |t|
      t.string :name
      t.string :created_by
      t.string :modified_by
      t.integer :completed_percentage
      
      t.timestamps
    end
  end

  def down
    drop_table :campaign_completed_stages
  end
end
