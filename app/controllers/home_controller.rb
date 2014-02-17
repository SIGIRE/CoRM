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
	@count = Hash.new
    @count[:user] = User.all_reals.count
	@count[:account] = Account.count
	@count[:contact] = Contact.count
	@count[:event] = Event.count
	@count[:event_type] = EventType.count
	@count[:task] = Task.count
	@count[:opportunity] = Opportunity.count
	@count[:quotation] = Quotation.count
	@count[:quotation_template] = QuotationTemplate.count
	@count[:document] = Document.count
	@count[:email] = Email.count
	
	@bdd_size = Hash.new
	@bdd_size[:event] = get_attach_size_of_nested(Event)
	@bdd_size[:task] = get_attach_size_of(Task)
	@bdd_size[:document] = get_attach_size_of(Document)
	@bdd_size[:quotation] = get_attach_size_of(Quotation)
	@bdd_size[:opportunity] = get_attach_size_of(Opportunity)
	@bdd_size[:email] = get_attach_size_of_nested(Email)
	
	total = 0
	@bdd_size.each do | e, i |
		total += i
	end
	@bdd_size[:total]=total
	
	render "stats"
	else
		@page = params[:page]
		# task-block
		@tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("statut ASC, priority DESC, term DESC").limit(5)
		@tasks_count = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).count() - 5
		# events-block
		@events = Event.where('account_id IS NOT NULL').order('id DESC').limit(5)
		@opportunities = Opportunity.where("user_id =? AND statut IN ('Détectée','En cours')", current_user.id).order("created_at DESC , updated_at DESC").limit(5)
		#@opportunities = Opportunity.last_modified(5)
		#@quotations = Quotation.last_modified(5)
		@quotations = Quotation.where("user_id =? AND statut IN ('Sauvegardé','En cours')", current_user.id).order("created_at DESC , updated_at DESC").limit(5)
		#@emails = Email.where("user_id = ?", current_user.id)
		respond_to do |format|
		  format.html # index.html.erb
		end
	end
  end
  
  def update
		events = params[:events]
		
		@events
  end
  
  def get_attach_size_of(object)
	size = 0
	object.all.each do |o|
		size += o.attach_file_size unless o.attach_file_size.nil?
	end
	return size
  end
  
    def get_attach_size_of_nested(object)
    size = 0
	    object.all.each do |o|
	        o.attachments.each do |attachment|
		        size += attachment.attach_file_size unless attachment.attach_file_size.nil?
		    end
	    end
	    return size
    end
end
