class ChangeRemarkTypeToOpportunities < ActiveRecord::Migration
  def change
    change_column :opportunities, :remark, :text
  end
end
