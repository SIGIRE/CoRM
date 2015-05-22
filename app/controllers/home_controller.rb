# encoding: utf-8

##
# Controller that manage About page
#
class HomeController < ApplicationController
  
  ##
  # About page
  #
  
  has_scope :by_user_id
  has_scope :by_author_user_id  
  
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
	@bdd_size[:event] = get_attach_size_of(Event)
	@bdd_size[:task] = get_attach_size_of(Task)
	@bdd_size[:document] = get_attach_size_of(Document)
	@bdd_size[:quotation] = get_attach_size_of(Quotation)
	@bdd_size[:opportunity] = get_attach_size_of(Opportunity)
	@bdd_size[:email] = get_attach_size_of(Email)
	
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
		@events = Event.where('account_id IS NOT NULL').order('id DESC').limit(10)
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
	        o.attachments.each do |attachment|
		        size += attachment.attach_file_size unless attachment.attach_file_size.nil?
		    end
	    end
	    return size
    end
    
    def reporting

	  
	  @start_at = Time.zone.parse(params[:start_at]) unless params[:start_at].blank?
	  @end_at = Time.zone.parse(params[:end_at]).end_of_day unless params[:end_at].blank?
	  @start_at= ((DateTime.now) - 30.day).beginning_of_day unless !@start_at.blank?
	  @end_at= DateTime.now.end_of_day unless !@end_at.blank?
	  
	  @user_id = params[:by_user_id]
	  @author_user_id = params[:by_author_user_id]
	  if !@user_id.blank? then user = User.find(@user_id) else user = nil end
	  if !@author_user_id.blank? then author_user = User.find(@author_user_id) else author_user = nil end
	  
	  if user.blank? then @user_name = "" else @user_name = user.full_name end
	  if author_user.blank? then @author_user_name = "" else @author_user_name = author_user.full_name end
	  
	  # Use "scoped" to return an anonymous ActiveRecord Relation. With "all", it is just an array and no more scopes can be applied
	  @events = apply_scopes(Event).with_event_type.between_dates(@start_at, @end_at).scoped
	  @tasks = apply_scopes(Task).between_dates(@start_at, @end_at).scoped
	  @opportunities = apply_scopes(Opportunity).between_dates(@start_at, @end_at).scoped
	  @quotations = apply_scopes(Quotation).between_dates(@start_at, @end_at).scoped
	  #if (@user_id.blank? or (User.find_by_id(@user_id).blank?))
	  #  @events = Event.between_dates(@start_at, @end_at).with_event_type
	  #  @tasks = Task.between_dates(@start_at, @end_at)
	  #  @opportunities = Opportunity.between_dates(@start_at, @end_at)
	  #  @quotations = Quotation.between_dates(@start_at, @end_at)
	  #else
	  #  @events = Event.between_dates(@start_at, @end_at).by_user_id(@user_id).with_event_type
	  #  @tasks = Task.between_dates(@start_at, @end_at).by_user_id(@user_id)
	  #  @opportunities = Opportunity.between_dates(@start_at, @end_at).by_user_id(@user_id)
	  #  @quotations = Quotation.between_dates(@start_at, @end_at).by_user_id(@user_id)
	  #end
	   respond_to do |format|
		  format.html 
		  format.xlsx
	   end	  
    end
    
    # GET /search_by_phone/:phone_number
    def search_by_phone
	  @phone_number = params[:phone_number]
	  case
	    when @phone_number.blank?
		  respond_to do |format|
			format.html # search_by_phone.html.erb
		  end
	    #if contains alphabetic characters
	    when (@phone_number =~ /[[:alpha:]]/)
		@accounts = Account.where("company LIKE ?", @phone_number)
		if @accounts.blank?
			@contacts = Contact.where("surname LIKE ?", @phone_number)
			if @contacts.blank?
			      respond_to do |format|
				    format.html # search_by_phone.html.erb
			      end
			elsif (@contacts.count ==1 and !@contacts.first.account.blank?)
			      #found one only!
			      redirect_to account_events_url(@contacts.first.account)
			else
			      respond_to do |format|
				    format.html # search_by_phone.html.erb
			      end
			end
		elsif @accounts.count == 1
		      #found one only !
		      redirect_to account_events_url(@accounts.first)
		else
		      	respond_to do |format|
			      format.html # search_by_phone.html.erb
			end
		end
	    else
		# search in accounts
		@accounts = Account.where("REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(tel, '/',''), '-', ''), '+', ''), '.', ''), ',', ''), ' ', '') LIKE ?", '%'+@phone_number.delete("^0-9")+'%')
		if @accounts.blank?
		  #no result : search in contacts
		  @contacts = Contact.where("(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(tel, '/',''), '-', ''), '+', ''), '.', ''), ',', ''), ' ', '') LIKE ?) OR (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(mobile, '/',''), '-', ''), '+', ''), '.', ''), ',', ''), ' ', '') LIKE ?)", '%'+@phone_number.delete("^0-9")+'%', '%'+@phone_number.delete("^0-9")+'%')
			if @contacts.blank?
			      respond_to do |format|
				    format.html # search_by_phone.html.erb
			      end
			elsif @contacts.count == 1
			      #found one only!
			      @account = Account.find(@contacts.first.account.id)
			      redirect_to account_events_url(@account)
			else
			      respond_to do |format|
				    format.html # search_by_phone.html.erb
			      end
			end
	        elsif @accounts.count == 1
		      #found one only !
		      redirect_to account_events_url(@accounts.first)
		else
		      	respond_to do |format|
			      format.html # search_by_phone.html.erb
			end
		end
	  end
    end
    
    
end
