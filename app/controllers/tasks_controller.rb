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
    @task = Task.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @task }
    end
  end
  
  ##
  # Process to create a new Task
  #
  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @task.user = current_user
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @task }
    end
  end

  ##
  # Render a page to edit a existing task
  #
  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    
    #conversion de la string term pour qu'elle soit formatté correctement pour l'afficahge
    @task.term = @task.term.split('/').reverse!.join('/')
  end

  ##
  # Process to create a new task into the DB
  #
  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.created_by = current_user.id
    
    #idem que dans edit
    @task.term = @task.term.split('/').reverse!.join('/')
    
    
    respond_to do |format|
      if @task.save
        
	#si le checkbox est cochée 
	if params[:mail]=="yes"
	  #mailing
	  UserMailer.create_task_email(@task.user,@task).deliver
	end
        
        #pour que la task ait un id 
        self.create_event(false)
        format.html { redirect_to tasks_path, :notice => 'La tâche a été créée.' }
        format.json { render :json => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Process that update a task into the DB
  #
  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.modified_by = current_user.id
    params[:task][:term] = params[:task][:term].split('/').reverse!.join('/')
        
    respond_to do |format|
      if @task.update_attributes(params[:task])
	    #si le checkbox est cochée 
	    if params[:mail]=="yes"
	      #mailing
	      UserMailer.update_task_email(@task.user,@task).deliver
	    end
        
        self.create_event(true)
        format.html { redirect_to tasks_url, :notice => 'La tâche a été mise à jour.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Process that remove a Task from the DB
  #
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
  
  ##
  # Generate dynamically a Contact List by the Account
  #
  def update_contact_select
    if !params[:id].nil?
      if params[:id].is_a? Integer 
	contacts = Contact.where(:account_id => params[:id]).select('id, surname, forename, title').order(:surname)
      elsif params[:id].is_a? String 
	contacts = Contact.joins('INNER JOIN accounts ON accounts.id = contacts.account_id').where('company LIKE ?', params[:id]+'%').select('contacts.id, contacts.surname, contacts.forename, contacts.title').order(:surname)
      end
      if !contacts.nil?
	respond_to do |format|
	  format.json { render :json => contacts }
	end
	return false
      end
    end
    c = Contact.new({ 'surname' => 'Aucun contacts' })
    respond_to do |format|
      format.json { render :json => [c] }
    end
    # render :partial => "contacts" , :locals =>{:contacts => contacts }  
  end
  
  ##
  # Search bar filter handler
  #
  def filter
    
    #filter data
    if params.has_key?(:filter) then
      @email_filter = params[:filter][:user_email]
      @statut_filter = params[:filter][:statut]
    else
      @email_filter = current_user.email
      @statut_filter = "Non terminé"
    end
    
    # Search User by @email_filer
    user = User.find(:first, :conditions => ['email LIKE ?', @email_filter])

    # Sort tasks by statut_filter
    if @statut_filter == "Non terminé" then
	    @tasks = Task.by_statut_non_termine(@statut_filter).by_user(user)
    else
        @tasks = Task.by_statut(@statut_filter).by_user(user)
    end
    
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

