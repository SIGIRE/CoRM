class Setting < ActiveRecord::Base
    
    attr_accessible :key, :value, :input_type
    
    set_primary_key :key
    
    def self.get(id)
      return self.find(id)
    end
    
    def self.set(id, value, options = {})
      setting = self.find_by_key(id)
      if (!setting.nil?)
          return self.find(id).update_attribute(:value, value)
      else
          setting_instance = Setting.new
          setting_instance.key = id
          setting_instance.value = value
          setting_instance.input_type = !options[:type].nil? ? options[:type] : "text"
          setting_instance.save()
      end
    end
    
end
