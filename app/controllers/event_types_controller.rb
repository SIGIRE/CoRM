# encoding: utf-8

##
# This class manage EventType
#
class EventTypesController < ApplicationController
  
  ##
  # Show the full list of EventType by paginate_by
  #
  # GET /eventtypes
  # GET /eventtypes.json
  def index
    @eventtypes = EventType.order("label","direction").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @types }
    end
  end

  ##
  # Show one occurence of EventType
  #
  # GET /type-evenements/1
  # GET /type-evenements/1.json
  #
  def show
    @eventtype = EventType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @type }
    end
  end

  ##
  # Render a page with a form to create a new EventType
  #
  # GET /type-evenements/new
  # GET /type-evenements/new.json
  def new
    @eventtype = EventType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @type }
    end
  end
  
  ##
  # Render a page to edit one occurence of EventType
  #
  # GET /type-evenements/1/edit
  def edit
    @eventtype = EventType.find(params[:id])
  end

  ##
  # Save an instance of EventType to the DB
  #
  # POST /type-evenements
  # POST /type-evenements.json
  def create
    @eventtype = EventType.new(params[:type])
    @eventtype.created_by = current_user.id
    @eventtype.modified_by = current_user.id
    
    respond_to do |format|
      if @eventtype.update_attributes(params[:event_type])
        format.html { redirect_to eventTypes_url, :notice => 'Le type a été créé.' }
        format.json { render :json => @eventtype, :status => :created, :location => @eventtype }
      else
        format.html { render :action => "new" }
        format.json { render :json => @eventtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Save an instance of EventType which already exists
  #
  # PUT /type-evenements/1
  # PUT /type-evenements/1.json
  def update
    @eventtype = EventType.find(params[:id])
    @eventtype.modified_by = current_user.full_name
    respond_to do |format|
      if @eventtype.update_attributes(params[:event_type])
        format.html { redirect_to eventTypes_path, :notice => 'Le type a été mis à jour.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @eventtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Delete an EventType stored into the DB
  #
  # DELETE /type-evenements/1
  # DELETE /type-evenements/1.json
  def destroy
    @eventtype = EventType.find(params[:id])
    @eventtype.destroy

    respond_to do |format|
      format.html { redirect_to eventTypes_url }
      format.json { head :no_content }
    end
  end
  
end
