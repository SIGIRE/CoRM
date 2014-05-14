# encoding: utf-8
class WebmailConnection < ActiveRecord::Base
  attr_accessible :login, :password, :port, :server, :type_event_id, :active

  def self.check(connection)
    require 'mail'
    if (!connection.type_event_id.nil?)
      puts("Connexion recuperee : #{connection.server}:#{connection.port} (#{connection.login}:#{connection.password})")
      puts("Attempting to connect to the specified email server...")
      Mail.defaults do
        retriever_method :pop3, 
          :address 	=> connection.server,
          :port		=> connection.port,
          :user_name 	=> connection.login,
          :password 	=> connection.password,
          :enable_ssl 	=> false
        email = Mail.first
      end
    else
      puts("Type d'évènement non défini!")
      raise "Unset EventType Exception"
    end
  rescue => msg
    puts("Unconnected - #{msg}")
    false
  else
    puts("Connected")
    true
  end
end
