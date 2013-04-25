class AddMargeToOpportunitees < ActiveRecord::Migration
  	def up
    	add_column :opportunitees, :marge, :float
	end

  
  	def down
    	remove_column :tablenames, :marge
	end
end
