class CreateCampaignResultStages < ActiveRecord::Migration
  def up
    create_table :campaign_result_stages do |t|
      t.string :name
      t.string :created_by
      t.string :modified_by
      t.integer :result_percentage

      t.timestamps
    end
  end

  def down
    drop_table :campaign_result_stages
  end
end
