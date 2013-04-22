# encoding: utf-8

##
# Controller that manage About page
#
class HomeController < ApplicationController
  
  ##
  # About page
  #
  # GET /types
  # GET /types.json
  def index
	if current_user.has_role? :admin 
	@user_count = User.all_reals.count
	
	
	
	render "stats"
	else
		@page = params[:page]
		# task-block
		@tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("created_at DESC , updated_at DESC").limit(5)
		@tasks_count = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).count() - 5
		# events-block
		@events = Event.order('id DESC').limit(6)
		@opportunities = Opportunity.last_modified(5)
		@quotations = Quotation.last_modified(5)
		respond_to do |format|
		  format.html # index.html.erb
		end
	end
  end
  
  def update
		events = params[:events]
		
		@events
  end
  
  
  
end
