class AddSslToWebmailConnections < ActiveRecord::Migration
  def up
    add_column :webmail_connections, :ssl, :boolean, :default => false
  end

  def down
    remove_column :webmail_connections, :ssl
  end
end
