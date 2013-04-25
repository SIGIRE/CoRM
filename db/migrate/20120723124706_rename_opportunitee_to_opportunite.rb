class RenameOpportuniteeToOpportunite < ActiveRecord::Migration
  def change
        rename_table :opportunitees, :opportunites
  end 
end
