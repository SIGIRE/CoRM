class AddUserRelation < ActiveRecord::Migration
  # Fields to update
  def init
    @elements = Hash[
      "events" => [
        "created_by",
        "modified_by"
      ],
      "accounts" => [
        "created_by",
        "modified_by"
      ],
      "contacts" => [
        "created_by",
        "modified_by"
      ],
      "documents" => [
        "created_by",
        "updated_by"
      ],
      "opportunities" => [
        "created_by",
        "updated_by"
      ],
      "quotations" => [
        "created_by",
        "updated_by"
      ],
      "origins" => [
        "created_by",
        "updated_by"
      ],
      "tags" => [
        "created_by",
        "updated_by"
      ],
      "tasks" => [
        "created_by",
        "modified_by"
      ],
      "event_types" => [
        "created_by",
        "modified_by"
      ]
    ]
  end
  
  def up
    ActiveRecord::Base.record_timestamps = false
    # add Primary Key
    execute <<-SQL
      ALTER TABLE accounts_tags
        ADD CONSTRAINT pk_accounts_tags
        PRIMARY KEY (account_id, tag_id);
        
      ALTER TABLE contacts_tags
        ADD CONSTRAINT pk_contacts_tags
        PRIMARY KEY (contact_id, tag_id);
    SQL
    
    # modified_by objects
    
    changeTablesUp(Event, :created_by)
    changeTablesUp(Event, :modified_by)
    
    changeTablesUp(Account, :created_by)
    changeTablesUp(Account, :modified_by)
    
    changeTablesUp(Contact, :created_by)
    changeTablesUp(Contact, :modified_by)
    
    changeTablesUp(Task, :created_by)
    changeTablesUp(Task, :modified_by)
    
    changeTablesUp(EventType, :created_by)
    changeTablesUp(EventType, :modified_by)
    
    # updated_by objects
    
    changeTablesUp(Document, :created_by)
    changeTablesUp(Document, :updated_by)
    
    changeTablesUp(Opportunity, :created_by)
    changeTablesUp(Opportunity, :updated_by)
    
    changeTablesUp(Origin, :created_by)
    changeTablesUp(Origin, :updated_by)
    
    changeTablesUp(Quotation, :created_by)
    changeTablesUp(Quotation, :updated_by)
    
    changeTablesUp(Tag, :created_by)
    changeTablesUp(Tag, :updated_by)

    init()
    
    @elements.each do |table_name, table|
      table.each do |column|
        changeTableType(table_name, column, "string", "integer")
        addFK(table_name, column)
      end
    end
    ActiveRecord::Base.record_timestamps = true
  end

  def down
    ActiveRecord::Base.record_timestamps = false
    # rem Primary Key
    execute <<-SQL
      ALTER TABLE accounts_tags
        DROP CONSTRAINT IF EXISTS pk_accounts_tags;
        
      ALTER TABLE contacts_tags
        DROP CONSTRAINT IF EXISTS pk_contacts_tags;
    SQL
    
    init()
    # Drop foreign key
    # ALTER TABLE
    @elements.each { |table_name, table|
      table.each { |column|
        remFK(table_name, column)
        changeTableType(table_name, column, "integer", "string")
      }
    
    }

    @elements.each do |table_name, table|
      table.each do |column|
        remFK(table_name, column)
        changeTableType(table_name, column, "integer", "string")
      end
    end
    
    # modified_by objects
    
    changeTablesDown(Event, :created_by)
    changeTablesDown(Event, :modified_by)
    
    changeTablesDown(Account, :created_by)
    changeTablesDown(Account, :modified_by)
    
    changeTablesDown(Contact, :created_by)
    changeTablesDown(Contact, :modified_by)
    
    changeTablesDown(Task, :created_by)
    changeTablesDown(Task, :modified_by)
    
    changeTablesDown(EventType, :created_by)
    changeTablesDown(EventType, :modified_by)
    
    # updated_by objects
    
    changeTablesDown(Document, :created_by)
    changeTablesDown(Document, :updated_by)
    
    changeTablesDown(Opportunity, :created_by)
    changeTablesDown(Opportunity, :updated_by)
    
    changeTablesDown(Origin, :created_by)
    changeTablesDown(Origin, :updated_by)
    
    changeTablesDown(Quotation, :created_by)
    changeTablesDown(Quotation, :updated_by)
    
    changeTablesDown(Tag, :created_by)
    changeTablesDown(Tag, :updated_by)
    ActiveRecord::Base.record_timestamps = true
  end
  
  ##
  # 
  #
  def changeTablesUp(o, field)
    # Get class name for logs
    class_name = o.new.class.name
    logger.info("BEGIN on #{class_name}")
    # for each value in the table
    o.all.each do |value|
      # split field ('created_by' => 'Matthieu BOHEAS' ==> ['Matthieu', 'BOHEAS'])
      names = value[field].blank?  ? '' : value[field].split(' ')
      # if the Array/String length > 0, then add it to the users array with line key
      if names.length > 0
        # Get the user if exists
        currentUser = User.where({ :surname => names[1], :forename => names[0] }).first()
        if currentUser.nil?
          currentUser = User.where({ :surname => names[0], :forename => names[1] }).first()
          if currentUser.nil?
            currentUser = User.find_by_email(value[field])
            if currentUser.nil?
              if User.where({ :surname => names[1] }).count() == 1
                currentUser = User.where({ :surname => names[1] }).first()
              elsif User.where({ :forename => names[0] }).count() == 1
                currentUser = User.where({ :forename => names[0] }).first()
              end
            end
            
          end
          
        end
        # if user exists, update created_by by currentUser.id
        if !currentUser.nil?
          logger.info("Change #{class_name}.#{field} from #{currentUser.full_name} to #{currentUser.id.to_s}")
          value.update_attributes({ field => currentUser.id.to_s })
        else
          logger.info('The current User does not exist or table field is not filled')
          value.update_attributes({ field => nil })
        end
      end
    end
    logger.info("END OF #{class_name}")
  end
  
  ##
  # 
  #
  def changeTablesDown(o, field)
    i = 0
    o.all.each do |value|
      id = value[field]
      i += 1
      # if the Array/String length > 0, then add it to the users array with line key
      if !id.blank?
        currentUser = User.find(id)
        if !currentUser.nil?
          logger.info("Change #{o.class.name}.#{field} from #{currentUser.id.to_s} to #{currentUser.full_name}")
          value.update_attributes({ field => currentUser.full_name })
        else
          logger.info('The current User does not exist or table field is not filled')
        end
      end
    end
    return i
  end
  
  def changeTableType(table, column, old_type, type)
    logger.info("Change table #{table} with column #{column} type was #{old_type} and is now #{type}")
    if (type == 'string')
      type = 'varchar(255)'
    end
    
    query = "ALTER TABLE #{table} ALTER COLUMN #{column} TYPE #{type}"
    if (type == 'integer' && old_type == 'string')
      query.concat(" USING (trim(#{column})::integer)")
    end  
    execute(query)
  end
  
  def addFK(table, column)
    logger.info("ADD FOREIGN KEY TO #{table} AT #{column}")
    query = "ALTER TABLE #{table} ADD CONSTRAINT \"fk_users_#{table}_#{column}\" FOREIGN KEY (#{column}) REFERENCES users(id);"
    execute(query)
  end
  
  def remFK(table, column)
    logger.info("REMOVE FOREIGN KEY TO #{table} AT #{column}")
    execute "ALTER TABLE #{table} DROP CONSTRAINT IF EXISTS \"fk_users_#{table}_#{column}\";"
  end
end
