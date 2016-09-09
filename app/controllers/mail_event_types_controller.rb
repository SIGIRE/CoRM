# encoding: utf-8

##
# The Controller that manage the event's types of emails
#
class MailEventTypesController < ApplicationController
  
  load_and_authorize_resource

  ##
  # Display the list of all MailEventTypes by paginate_by
  #
  # GET /mail_event_types
  def index
    @mail_event_types = MailEventType.order('name').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #
  ## Render a page to create new MailEventType
  #
  # GET /mail_event_types/new
  def new
    @mail_event_type = MailEventType.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  #
  ## Render a page to update an MailEventType
  #
  # GET /mail_event_types/1/edit
  def edit
    @mail_event_type = MailEventType.find(params[:id])
  end

  #
  ## Create a new MailEventType
  #
  # POST /mail_event_types
  def create
    @mail_event_type = MailEventType.new(params[:mail_event_type])
    @mail_event_type.created_by = current_user.id

    respond_to do |format|
      if @mail_event_type.save
        format.html { redirect_to mail_event_types_path, notice: "#{t('app.message.notice.created_mail_event_type')}" }
      else
        format.html { render action: "new" }
      end
    end
  end

  #
  ## Update an existing MailEventType
  #
  # PUT /mail_event_types/1
  def update
    @mail_event_type = MailEventType.find(params[:id])
    @mail_event_type.updated_by = current_user.id
    
    respond_to do |format|
      if @mail_event_type.update_attributes(params[:mail_event_type])
        format.html { redirect_to mail_event_types_url, notice: "#{t('app.message.notice.updated_mail_event_type')}" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  #
  ## Delete an existing MailEventType
  #
  # DELETE /mail_event_types/1
  def destroy
    @mail_event_type = MailEventType.find(params[:id])
    @mail_event_type.destroy

    respond_to do |format|
      format.html { redirect_to mail_event_types_url, notice: "#{t('app.message.notice.deleted_mail_event_type')}"  }
    end
  end
end
