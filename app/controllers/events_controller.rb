# encoding: utf-8

##
# This class manage Event
#
class EventsController < ApplicationController
  
  ##
  # Show the full list of Events  
  #
  # GET /events     Account.order("company").page(params[:page]).per(3)
  # GET /events.json
  def index
    
    if params[:account_id] == nil  then
      @events = Event.page(params[:page])
    else
      @account = Account.find(params[:account_id])    
      @events = @account.events.order("date_begin DESC").page(params[:page])
      @event_new = @account.events.build 
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  ##
  # Render the page to show one Event
  #
  # GET /events/1
  # GET /events/1.json
  def show
    if @ability.cannot? :read, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to events_url
	  return false
    end
    @event = Event.date_end(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @event }
    end
  end
  
  ##
  # Render the page with the form to create an Event
  #
  # GET /events/new
  # GET /events/new.json
  def new
    if @ability.cannot? :create, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to events_url
	  return false
    end
    @event = Event.new
    @event.account_id = params[:account_id]
    @event.date_end = Date.today

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  ##
  # Render the page to edit an existing event
  #
  # GET /events/1/edit
  def edit
    if @ability.cannot? :update, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to events_url
	  return false
    end
    @event = Event.find(params[:id])
  end

  ##
  # Process to create an new Event
  #
  # POST /events
  # POST /events.json
  def create
    if @ability.cannot? :create, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to events_url
	  return false
    end
    @event = Event.new(params[:event])
    @event.created_by = current_user.id
    
    @event.date_begin = params[:event][:date_begin]
    @event.date_begin = @event.date_begin.change({:hour => params[:event]["date_begin(4i)"].to_i, :min => params[:event]["date_begin(5i)"].to_i}) 

    @event.date_end = params[:event][:date_end]
    @event.date_end = @event.date_end.change({:hour => params[:event]["date_end(4i)"].to_i, :min => params[:event]["date_end(5i)"].to_i}) 
    if params[:generate]== "yes"
      @event.notes2 = params[:notes]
      self.create_task
    end
		if @event.save
			flash[:notice] = "L'évènement a été créé."
			if params[:generate] == "yes" and params[:mail] == "yes"
				UserMailer.mail_for(@event.user, @event.task, true).deliver
				flash[:notice] += "<br>Un email a été envoyé à #{@event.user.full_name}."
			end
			redirect_to account_events_url(@event.account_id)
		else
			render :action => "new"
		end
  end

  ##
  # Modify an existing event into the DataBase
  #
  # PUT /events/1
  # PUT /events/1.json
  def update
    if @ability.cannot? :update, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to events_url
	  return false
    end
    @event = Event.find(params[:id])
    @event.modified_by = current_user.id
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => "L'évènement a été mis à jour." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Remove an existing Event from the Database
  #
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if @ability.cannot? :destroy, Event
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.Event'))
      redirect_to opportunities_url
	  return false
    end
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "L'évenement a été correctement supprimé"
    redirect_to account_events_url(@event.account_id)
  end
  
  ##
  # Create a task for this event
  #
  def create_task()
    
    # Create a new hashtable with the same key as can do the TasksController
    hash = Hash.new
    hash['account_id'] = params[:event][:account_id]
    hash['contact_id'] = params[:event][:contact_id]
    hash['user_id'] = params[:event][:user_id]
    hash['notes'] = params[:task][:notes]
    hash['statut'] = params[:task][:statut]
    hash['term'] = params[:task][:term].split('/').reverse!.join('/')
    hash['created_by'] = current_user.id
    hash['priority'] = params[:task][:priority].to_i
    hash['title'] = params[:task][:title]
    
    # Create the task with the hash
    @task = Task.new(hash)
    if @task.save
      @event.task_id = @task.id
      return true
    else
      return false
    end
  end
end
