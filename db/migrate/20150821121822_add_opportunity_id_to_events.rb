class AddOpportunityIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :opportunity_id, :integer
  end
end
