class AddUserRelation < ActiveRecord::Migration
  def up
    require '/home/matthieu/Documents/projets/crm/app/models/user.rb'
    require '/home/matthieu/Documents/projets/crm/app/models/event.rb'
    # catch all names in events table
    events = Event.find(:all)
    users = Array.new
    
    events.each do |value, key|
      names = value.created_by.blank?  ? '' : value.created_by.split(' ')
      if names.length == 0
        continue
      end
      
      currentUser = User.where({ :surname => names[0], :forename => names[1] }).first()
      if currentUser.blank?
        currentUser = User.where({ :surname => names[0], :forename => names[1] }).first()
      end
      if !currentUser.blank?
        users[key] = currentUser.id
      end
    end
    
    # change column
    change_column( :events, :created_by, :integer )
    # ALTER TABLE
    execute <<-SQL
      ALTER TABLE events
        ADD CONSTRAINT 'fk_users_events'
        FOREIGN KEY (created_by)
        REFERENCES users(id);
    SQL
    
    users.each do |value, key|
      events[key] = users[key]
      events.save
    end
  end

  def down
    # catch all names in events table
    events = Event.find(:all)
    users = Array.new
    
    for key, value in events
      currentUser = User.find_by_id(value[:created_by])
      if !currentUser.blank?
        users[key] = currentUser.full_name
      end
    end
    
        # ALTER TABLE
    execute <<-SQL
      ALTER TABLE events
        DROP CONSTRAINT 'fk_users_events'
    SQL
    
    # change column
    change_column( :events, :created_by, :text )

    
    for key, value in users
      events[key] = users[key]
      events.save
    end
  end
end
