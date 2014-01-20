class CreateWebmailConnections < ActiveRecord::Migration
  def change
    create_table :webmail_connections do |t|
      t.string :login
      t.string :password
      t.string :server
      t.integer :port
      t.integer :type_event_id

      t.timestamps
    end
  end
end
