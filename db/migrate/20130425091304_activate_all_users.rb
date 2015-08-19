class ActivateAllUsers < ActiveRecord::Migration
  def change
    User.all.each do |u|
      u.update_attribute(:enabled, true)
    end
  end
end
