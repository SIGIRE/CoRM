class SetTasksWithNoPriorityToNormal < ActiveRecord::Migration
  def up
    Task.where('priority = NULL').each do |t|
      t.update_attribute(:priority, 1)
    end    
  end

  def down
    Task.where('priority = 1').each do |t|
      t.update_attribute(:priority, nil)
    end
  end
end
