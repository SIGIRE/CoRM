# encoding: utf-8

##
# The Controller that manage Campaigns
#
class CampaignsController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all Campaigns by paginate_by
  #
  # GET /campaigns
  def index
    @campaigns = Campaign.order('date_begin DESC').page(params[:page])

    respond_to do |format|
      format.html  # index.html.erb
    end
  end

  ##
  # Render a page to create new Campaign
  #
  def new
    @campaign = Campaign.new

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  ##
  # Process to insert a new Campaign into the DataBase
  #
  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.created_by = current_user.id

    respond_to do |format|
      if @campaign.save
        format.html  { redirect_to campaigns_path, :notice => t('app.message.notice.created_campaign') }
      else
        format.html  { render :action => "new" }
      end
    end
  end


  def edit
    @campaign = Campaign.find(params[:id])
  end

  ##
  # Process that udpate an existing Campaign
  #
  def update
    @campaign = Campaign.find(params[:id])
    @campaign.modified_by = current_user.id

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html  { redirect_to(campaigns_url, :notice => t('app.message.notice.updated_campaign')) }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end

  ##
  # Process that remove a Campaign from the DB
  #
  def destroy
      @campaign = Campaign.find(params[:id])
      respond_to do |format|
        begin  
          if @campaign.destroy
            format.html  { redirect_to(campaigns_url, :notice => t('app.message.notice.deleted_campaign')) }
          else
            flash[:error] = t('app.delete_undefined_error')
            format.html  { render :action => "edit" }      
          end
        rescue ActiveRecord::DeleteRestrictionError
          @campaign.errors.add(:base, t('errors.messages.restrict_dependent_destroy', count: 1))
        ensure
          format.html  { render :action => "edit" }
        end
      end
  end

end
