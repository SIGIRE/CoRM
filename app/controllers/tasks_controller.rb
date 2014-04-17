# encoding: utf-8

##
# Controller that manage Tasks
#
class TasksController < ApplicationController
 
  has_scope :by_statut do |controller, scope, value|
    value == 'Non terminé' ? scope.undone : scope.by_statut(value)
  end
  has_scope :by_priority
  has_scope :by_account_company_like
  has_scope :by_contact_id
  has_scope :by_user_id
  has_scope :by_notes_like

  ##
  # Render a page to display a list of Tasks
  #
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = apply_scopes(Task)
    @tasks = @tasks.by_user(current_user).undone if current_scopes.empty? # Default filtering
    @tasks = @tasks.order("priority DESC, created_at DESC, updated_at DESC")
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
			redirect_to root_path
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
			redirect_to root_path
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
				redirect_to (@task.account.nil?() ? tasks_path : account_events_path(@task.account)), :notice => 'La tâche a été créée.'
			else
				@users = User.all_reals
				render :action => 'new'
			end
    else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
			redirect_to (@task.account.nil?() ? tasks_path : account_events_path(@task.account))
			return false
		end
  end

  ##
  # Process that update a task into the DB
  #
  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
        # Si l'utilisateur a le droit de modifier cette tâche, on continue
		if @ability.can? :update, Task
		
		    # Récupération de la tâche
			@task = Task.find(params[:id])
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
        self.create_event(true)
        redirect_to (@task.account.nil?() ? filter_tasks_path : account_events_path(@task.account))
      else
        render :action => "edit"
      end
		else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Task'))
			redirect_to root_path
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
	  redirect_to filter_tasks_path, :notice => 'La tâche a bien été supprimée'
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
  # Create an Event from a Task.
  # * *Args*    :
  #   - +updated+ -> if the object is updated(true) or created(false)
  #
  def create_event(updated)
    # Si le paramètre envoyé est false, 'type' = :create, sinon :update
	type = updated ? :update : :create
    if @ability.can? type, Event
            puts("Entrée dans les HASH")
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

