# encoding: utf-8

##
# This class manage EventType
#
class EventTypesController < ApplicationController
  
  def getAbility
    return Ability.new(current_user)
  end
  
  ##
  # Show the full list of EventType by paginate_by
  #
  # GET /type-evenements
  # GET /type-evenements.json
  def index
    @eventtypes = EventType.order("label","direction").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @eventtypes }
    end
  end

  ##
  # Show one occurence of EventType
  #
  # GET /type-evenement/1
  # GET /type-evenement/1.json
  #
  def show
    @eventtype = EventType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @eventtype }
    end
  end

  ##
  # Render a page with a form to create a new EventType
  #
  # GET /type-evenement/new
  # GET /type-evenement/new.json
  def new
    @eventtype = EventType.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @eventtype }
    end
  end
  
  ##
  # Render a page to edit one occurence of EventType
  #
  # GET /type-evenement/1/edit
  def edit
    if getAbility.can? :update, EventType
      @eventtype = EventType.find(params[:id])
    else
      redirect_to event_types_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.EventType'))
      return false
    end
  end

  ##
  # Save an instance of EventType to the DB
  #
  # POST /type-evenement
  # POST /type-evenement.json
  def create
    @eventtype = EventType.new(params[:type])
    @eventtype.created_by = current_user.id
    
    respond_to do |format|
      if @eventtype.update_attributes(params[:event_type])
        format.html { redirect_to event_types_url, :notice => 'Le type a été créé.' }
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
  # PUT /type-evenement/1
  # PUT /type-evenement/1.json
  def update
    @eventtype = EventType.find(params[:id])
    @eventtype.modified_by = current_user.id
    respond_to do |format|
      if @eventtype.update_attributes(params[:event_type])
        format.html { redirect_to event_types_path, :notice => 'Le type a été mis à jour.' }
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
  # DELETE /type-evenement/1
  # DELETE /type-evenement/1.json
  def destroy
    @eventtype = EventType.find(params[:id])
    @eventtype.destroy

    respond_to do |format|
      format.html { redirect_to event_types_url }
      format.json { head :no_content }
    end
  end
  
end
