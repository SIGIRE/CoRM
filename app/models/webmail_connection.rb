class WebmailConnection < ActiveRecord::Base
	attr_accessible :login, :password, :port, :server, :type_event_id, :active

	def check
		begin
			puts("Attempting to connect to the specified email server...")
			Mail.defaults do
			retriever_method :pop3, :address => :server,
					:port		 => :port,
					:user_name 	 => :login,
					:password 	 => :password,
					:enable_ssl 	 => false
			
			end
		rescue Exception => msg
			puts("Unconnected : #{msg}")
			false
		else
			puts("Connected")
			true
		end
	end
end
