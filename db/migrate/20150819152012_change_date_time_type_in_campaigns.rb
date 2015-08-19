class ChangeDateTimeTypeInCampaigns < ActiveRecord::Migration
  def up
    change_column :campaigns, :date_begin, :date
    change_column :campaigns, :date_end, :date
  end

  def down
    change_column :campaigns, :date_begin, :datetime
    change_column :campaigns, :date_end, :datetime
  end
end
