class Setting < ActiveRecord::Base
    
    attr_accessible :key, :value, :input_type
    
    self.primary_key = :key
    
    def self.get(id)
      return self.find_by_key(id)
    end
    
    def self.set(id, value, options = {})
      setting = self.find_by_key(id)
      if (!setting.nil?)
          return self.find_by_key(id).update_attribute(:value, value)
      else
          builder = {
            :key => id,
            :value => value,
            :input_type => !options[:type].nil? ? options[:type] : "text"
          }
          return self.create(builder)
      end
    end
    
    def set(value)
        self.update_attribute(:value, value)
    end
    
end
