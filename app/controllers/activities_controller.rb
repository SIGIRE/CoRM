# encoding: utf-8

##
# The Controller that manage Activity
#
class ActivitiesController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all Activities by paginate_by
  #
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.order('name').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @activities }
    end
  end
  
  ##
  # Render a page to create new Activity
  #
  def new
    @activity = Activity.new
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @activity }
    end
  end
  
  ##
  # Process to insert a new Activity into the DataBase
  #
  def create
    @activity = Activity.new(params[:activity])
    @activity.created_by = current_user.id

    respond_to do |format|
      if @activity.save
        format.html  { redirect_to activities_path, :notice => "L'activité a été créée." }
        format.json  { render :json => @activity, :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render a page to display an Activity
  #
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @activity }
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end
  
  ##
  # Process that udpate an existing Activity
  #
  def update
    @activity = Activity.find(params[:id])
    @activity.updated_by = current_user.id

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html  { redirect_to(activities_url, :notice => "L'activité a été mise à jour.") }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
        format.json  { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Process that remove an Activity from the DB
  #
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

end
