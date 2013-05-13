class CreateSettings < ActiveRecord::Migration
  def up
    create_table :settings, {:id=>false} do |t|
      t.string :key
      t.string :value
      t.string :input_type
    end
    execute "ALTER TABLE settings ADD PRIMARY KEY (key);"
    
    Setting.set('logo-login', './', { :type => 'file' })
  end
  
  def down
    drop_table :settings
  end
end
