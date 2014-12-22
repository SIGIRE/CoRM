class AddProbabilityColumnInOpportunities < ActiveRecord::Migration
  def up
    add_column :opportunities, :probability, :integer
  end

  def down
    remove_column :opportunities, :probability
  end
end
