# encoding: utf-8

##
# Controller that manage Tasks
#
class TasksController < ApplicationController
  
  ##
  # Render a page to display a list of Tasks
  #
  # GET /tasks
  # GET /tasks.json
  def index
    @page = params[:page]
    @tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("statut ASC ,term ASC").page(@page)
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tasks , :filter => @filter }
    end
  end

  ##
  # Render a page to display a form for one Task
  #
  # GET /tasks/1
  # GET /tasks/1.json
  def show 
	if @ability.can? :read, Task
	  @task = Task.find(params[:id])
	  
	  respond_to do |format|
		format.html # show.html.erb
		format.json { render :json => @task }
	  end
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end
  
  ##
  # Process to create a new Task
  #
  # GET /tasks/new
  # GET /tasks/new.json
  def new
	if @ability.can? :create, Task
	  @task = Task.new
	  @task.user = current_user
	  @users = User.all_reals
	  respond_to do |format|
		format.html # new.html.erb
		format.json { render :json => @task }
	  end
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end

  ##
  # Render a page to edit a existing task
  #
  # GET /tasks/1/edit
  def edit
	if @ability.can? :update, Task
	  @task = Task.find(params[:id])
	  @users = User.all_reals
	  #conversion de la string term pour qu'elle soit formatté correctement pour l'afficahge
	  @task.term = @task.term.split('/').reverse!.join('/')	
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end

  ##
  # Process to create a new task into the DB
  #
  # POST /tasks
  # POST /tasks.json
  def create
    if @ability.can? :create, Task
	  params[:task][:priority] = params[:task][:priority].to_i
	  @task = Task.new(params[:task])
	  @task.created_by = current_user.id
	  @task.term = @task.term.split('/').reverse!.join('/')
	  
	  if @task.save
	    if params[:mail] == "yes"
		  UserMailer.mail_for(@task.user, @task, true).deliver
	    end
        self.create_event(false)
		redirect_to filter_tasks_url, :notice => 'La tâche a été créée.'
	  else
	    @users = User.all_reals
        render :action => 'new'
	  end
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end

  ##
  # Process that update a task into the DB
  #
  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
	if @ability.can? :update, Task
	  @task = Task.find(params[:id])
	  @task.modified_by = current_user.id
	  params[:task][:term] = params[:task][:term].split('/').reverse!.join('/')
	  
	  if @task.update_attributes(params[:task])
		if params[:mail]=="yes"
		  UserMailer.mail_for(@task.user, @task, false).deliver
		end
		self.create_event(true)
		redirect_to filter_tasks_path, :notice => 'La tâche a été mise à jour.'
	  else
		render :action => "edit"
	  end
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end

  ##
  # Process that remove a Task from the DB
  #
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
	if @ability.can? :destroy, Task
	  @task = Task.find(params[:id])
	  @task.destroy
	  redirect_to filter_tasks_path, :notice => 'La tâche a été correctement supprimée'
    else
	  flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
	  redirect_to tasks_url
	  return false
	end
  end
  
  def isInt?(i)
    return i =~ /^-?[0-9]+$/
  end
  
  ##
  # Generate dynamically a Contact List by the Account
  #
  def update_contact_select
    if !params[:id].nil?
      int = params[:id].to_i if self.isInt?(params[:id])
      if !int.nil?
		contacts = Contact.where(:account_id => int).select('id, surname, forename, title').order(:surname)
      else
		contacts = Contact.joins('INNER JOIN accounts ON accounts.id = contacts.account_id').where('company LIKE ?', params[:id]+'%').select('contacts.id, contacts.surname, contacts.forename, contacts.title').order(:surname)
      end
      if !contacts.nil?
		render :json => contacts
		return true
      end
    end
    c = Contact.new({ 'forename' => 'Aucun contacts' })
    render :json => [c]
  end
  
  ##
  # Search bar filter handler
  #
  def filter
    
    #filter data
    if params.has_key?(:filter) then
      @email_filter = params[:filter][:user_email]
      @statut_filter = params[:filter][:statut]
	  @priority_filter = params[:filter][:priority]
    else
      @email_filter = current_user.email
      @statut_filter = "Non terminé"
	  @priority_filter = nil
    end

    if @priority_filter.blank?
	  @priority_filter = nil
	elsif @priority_filter.is_a? String then
	  Task::PRIORITIES.each_with_index do |value, index|
		if value == @priority_filter
		  @priority_filter = index
		end
	  end
	end
    # Search User by @email_filer
    user = User.find(:first, :conditions => ['email LIKE ?', @email_filter])

    # Sort tasks by statut_filter
    if @statut_filter == "Non terminé" then
	    @tasks = Task.by_statut_non_termine(@statut_filter).by_user(user)
	    if !@priority_filter.nil?
		  @tasks = @tasks.by_priority(@priority_filter)
		end
		
    else
        @tasks = Task.by_statut(@statut_filter).by_user(user)
        if !@priority_filter.nil?
		  @tasks = @tasks.by_priority(@priority_filter)
		end
    end
    
	# Sort task by priority
	#@tasks = Task.by_priority(@priority_filter).by_user(user)
	
    @tasks = @tasks.order("term ASC,statut DESC").page(params[:page])
    
    respond_to do |format|
      format.html  { render :action => "index" }
      format.json { render :json => @tasks, :filter => @filter }
    end

  end

  ##
  # Create an Event from a Task.
  # * *Args*    :
  #   - +updated+ -> if the object is updated(true) or created(false)
  #
  def create_event(updated)
	type = updated ? :update : :create
    if @ability.can? type, Event
	  #hash typé pour les params d'un event
	  hash = Hash.new
	  hash["event_type_id"] = params[:event_type][:id]
	  hash["account_id"] = params[:task][:account_id]
	  hash["contact_id"] = params[:task][:contact_id]
	  hash["date_begin"] = Time.now
	  hash["date_end"] = hash["date_begin"]
	  hash["notes"] = params[:notes]
	  hash["notes2"] = params[:task][:notes]
	  
	  # to test
	  if(updated == true)
		hash["modified_by"] = current_user.id
	  else
		hash["created_by"] = current_user.id
	  end
	  
	  hash["task_id"] = @task.id
	  @event = Event.create(hash)
	end
  end
  
end

