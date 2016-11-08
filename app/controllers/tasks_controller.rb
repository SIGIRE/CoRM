# encoding: utf-8

##
# Controller that manage Tasks
#
class TasksController < ApplicationController

  load_and_authorize_resource
  before_filter :load_account, :load_settings, only: [:index]
  layout :current_layout

  has_scope :by_statut do |controller, scope, value|
    value == 'Non terminé' ? scope.undone : scope.by_statut(value)
  end
  has_scope :by_priority
  has_scope :by_account_company_like
  has_scope :by_contact_id
  has_scope :by_user_id
  has_scope :by_author_user_id
  has_scope :by_notes_like

  ##
  # Render a page to display a list of Tasks
  #
  # GET /tasks
  # GET /tasks.json

  def index
    default_order = 'term'
    default_direction = 'DESC'
    @sort = params[:sort] || default_order
    @direction = params[:direction] || default_direction

    @tasks = apply_scopes(tasks)
    @tasks = @tasks.by_user(current_user).undone if current_scopes.empty? # Default filtering
    @tasks = @tasks.order("priority DESC, term ASC, created_at DESC, updated_at DESC")
                   .page(params[:page])

    flash.now[:alert] = "Pas de tâches !" if @tasks.empty?

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
    @task.account_id = params[:account_id]
    @users = User.all_reals

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
    @users = User.all_reals
    #conversion de la string term pour qu'elle soit formatté correctement pour l'afficahge
    @task.term = @task.term.split('/').reverse!.join('/')
  end

  ##
  # Process to create a new task into the DB
  #
  # POST /tasks
  # POST /tasks.json

  def create
    params[:task][:priority] = params[:task][:priority].to_i
    @task = Task.new(params[:task])
    @task.created_by = current_user.id
    @task.term = @task.term.split('/').reverse!.join('/')

    if @task.save
      if params[:mail] == "yes"
        UserMailer.mail_for(@task.user, @task, true).deliver
      end
      self.create_event(false)
      redirect_to session.delete(:return_to) || account_tasks_url(@event.account_id) , notice: "La tâche a été créée."
    else
      @users = User.all_reals
      render :action => 'new'
    end
  end

  ##
  # Process that update a task into the DB
  #
  # PUT /tasks/1
  # PUT /tasks/1.json

  def update
    # Récupération de la tâche
    @task = Task.find(params[:id])
    @task_before_update = Task.find(params[:id])
    @task.modified_by = current_user.id

    # Récupération de l'échéance de la tâche
    params[:task][:term] = params[:task][:term].split('/').reverse!.join('/')

    # check deep equality
    # t = Task.new(params[:task])
    # isEqual = (     @task.title == t.title and
    # 		        @task.priority == t.priority and
    # 			    @task.term == t.term and
    # 			    @task.statut == t.statut and
    # 			    @task.notes == t.notes and
    # 			    @task.contact_id == t.contact_id and
    # 			    @task.user_id == t.user_id and
    # 			    @task.account_id == t.account_id and
    # 			    @task.attachments == t.attachments)

    # if it is the same task but checkbox to generate event is checked
    # or task is not the same
    # then Create Event
    if @task.update_attributes(params[:task])
      flash[:notice] = "La tâche n°#{@task.id} a été mise à jour."
      if params[:mail]=="yes"
        UserMailer.mail_for(@task.user, @task, false).deliver
        flash[:notice] += " Un email a été envoyé à #{@task.user.full_name}"
      end
      if !(@task.statut == @task_before_update.statut)
        self.create_event(true)
      end
      redirect_to session.delete(:return_to) || (@event.blank? ? tasks_url : account_tasks_url(@event.account_id)), notice: "La tâche n°#{@task.id} a été mise à jour."
    else
      render :action => "edit"
    end
  end

  #finished task from action finished in index tasks view
  def finished
    # Récupération de la tâche
    @task = Task.find(params[:id])
    @task_before_update = Task.find(params[:id])
    @task.modified_by = current_user.id

    #conversion de la string term pour qu'elle soit formatté correctement pour l'afficahge
    #@task.term = @task.term.split('/').reverse!.join('/')

    # Set statut to closed
   @task.statut = tasks::STATUTS[2]

    if @task.update_attributes(params[:task])
      if !(@task.statut == @task_before_update.statut)
        # create event
        self.create_event(true)
      end
      
      flash[:notice] = "La tâche n°#{@task.id} a été mise à jour."
      redirect_to :back
    else
      render :action => "edit"
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
	  redirect_to session.delete(:return_to) || tasks_path, :notice => 'La tâche a bien été supprimée'
  end

  def isInt?(i)
    return i =~ /^-?[0-9]+$/
  end

  ##
  # Generate dynamically a Contact List by the Account

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
  # Create an Event from a Task.
  # * *Args*    :
  #   - +updated+ -> if the object is updated(true) or created(false)

  def create_event(updated)
    # Si le paramètre envoyé est false, 'type' = :create, sinon :update
	  type = updated ? :update : :create
    if can? type, Event
      hash = Hash.new
      hash["event_type_id"] = @task.event_type_id
      hash["account_id"] = @task.account_id
      hash["contact_id"] = @task.contact_id
      hash["date_begin"] = Time.now
      hash["date_end"] = hash["date_begin"]
      hash["notes2"] = @task.notes

      # to test
      if(updated == true)
        hash["modified_by"] = current_user.id
        hash["notes"] = 'Tâche "' + @task.title + '" modifiée. Le statut est passé de "' + @task_before_update.statut + '" à "' + @task.statut + '".'
      else
        hash["created_by"] = current_user.id
        hash["notes"] = 'Tâche "' + @task.title + '" créée avec statut "' + @task.statut + '".'
      end

      hash["task_id"] = @task.id
      @event = Event.create(hash)
    end
  end

  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end

    def load_settings
      #ClickToCall
      @setting = Setting.all.first
    end

    def tasks
      @account ? @account.tasks : Task
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end

end

