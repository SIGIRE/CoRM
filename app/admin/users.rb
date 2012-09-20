ActiveAdmin.register User do
	action_item :only => :index do
  		link_to('View on site', "/register")
	end
end
