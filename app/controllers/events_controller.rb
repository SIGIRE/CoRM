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
    @event = Event.find(params[:id])
  end

  ##
  # Process to create an new Event
  #
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.created_by = current_user.id
    
    @event.date_begin = params[:event][:date_begin]
    @event.date_begin = @event.date_begin.change({:hour => params[:event]["date_begin(4i)"].to_i, :min => params[:event]["date_begin(5i)"].to_i}) 

    @event.date_end = params[:event][:date_end]
    @event.date_end = @event.date_end.change({:hour => params[:event]["date_end(4i)"].to_i, :min => params[:event]["date_end(5i)"].to_i}) 
  
   
    #si le checkbox est cochée 
    if params[:generate]== "yes"
      #on génère une tâche
      @event.notes2 = params[:notes]
      self.create_task
    end
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to account_events_url(@event.account_id), :notice => "L'évènement a été créé." }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Modify an existing event into the DataBase
  #
  # PUT /events/1
  # PUT /events/1.json
  def update
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
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to account_events_url(@event.account_id) }
      format.json { head :no_content }
    end
  end
  
  ##
  # Create a task for this event
  #
  def create_task()
    
    # Create a new hashtable with the same key as can do the TasksController
    hash = Hash.new
    hash["account_id"] = params[:event][:account_id]
    hash["contact_id"] = params[:event][:contact_id]
    hash["user_id"] = params[:user_id]
    hash["notes"] = params[:notes]
    hash["statut"] = params[:statut][:statut]
    hash["term"] = params[:term].split('/').reverse!.join('/')
    hash["created_by"] = current_user.id
    
    # Create the task with the hash
    @task = Task.create(hash)
    @event.task_id = @task.id

    # if the checkbox is checked
    if params[:mail]=="yes"
        # mailing
        UserMailer.create_task_email(@task.user,@task).deliver
    end

  end
  
end
