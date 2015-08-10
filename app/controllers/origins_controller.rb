# encoding: utf-8

##
# The Controller that manage Origin
#
class OriginsController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all Origins by paginate_by
  #
  # GET /origins
  # GET /origins.json
  def index
    @origins = Origin.order('name').page(params[:page])

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @origins }
    end
  end

  ##
  # Render a page to create new Origin
  #
  def new
    @origin = Origin.new

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @origin }
    end
  end

  ##
  # Process to insert a new Origin into the DataBase
  #
  def create
    @origin = Origin.new(params[:origin])
    @origin.created_by = current_user.id

    respond_to do |format|
      if @origin.save
        format.html  { redirect_to origins_path, :notice => "L'origine a été créée." }
        format.json  { render :json => @origin, :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @origin.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Render a page to display an Origin
  #
  def show
    @origin = Origin.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @origin }
    end
  end

  def edit
    @origin = Origin.find(params[:id])
  end

  ##
  # Process that udpate an existing Origin
  #
  def update
    @origin = Origin.find(params[:id])
    @origin.updated_by = current_user.id

    respond_to do |format|
      if @origin.update_attributes(params[:origin])
        format.html  { redirect_to(origins_url, :notice => "L'origine a été mis à jour.") }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
        format.json  { render :json => @origin.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Process that remove an Origin from the DB
  #
  def destroy
    @origin = Origin.find(params[:id])
    @origin.destroy
    respond_to do |format|
      format.html { redirect_to origins_url }
      format.json { head :no_content }
    end
  end

end
