class PriorityPp < ActiveRecord::Migration
  def up
    p = Hash.new
    p["Bas"] = 0
    p["Normal"] = 1
    p["Haut"] = 2
    p["Urgent"] = 3

    t = Hash.new
    tasks = Task.all

    tasks.each {|e|
      if (e.priority.blank?() or e.priority.nil?)
        t[e.id] = p['Normal']
      else
        t[e.id] = p[e.priority]
      end
      e.update_attribute(:priority, nil)
    }
    changeTableType(:tasks, :priority, 'string', 'integer')
    tasks.each {|e|
      e.update_attribute(:priority, t[e.id])
    }
  end

  def down
    changeTableType(:tasks, :priority, 'integer', 'string')
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


end
