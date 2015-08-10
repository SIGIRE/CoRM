class AddActiveToWebmailConnections < ActiveRecord::Migration
  def change
    add_column :webmail_connections, :active, :boolean, :after => :type_event_id

    connections = WebmailConnection.all
    connections.each do |connection|
	connection.active = false
	connection.save
    end
  end
end
