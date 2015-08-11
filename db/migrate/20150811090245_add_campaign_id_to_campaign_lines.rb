class AddCampaignIdToCampaignLines < ActiveRecord::Migration
  def change
    add_column :campaign_lines, :campaign_id, :integer
  end
end
