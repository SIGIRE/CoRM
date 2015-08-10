# encoding: utf-8

##
# The Controller that manage CampaignCompletedStages
#
class CampaignCompletedStagesController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all CampaignCompletedStages by paginate_by
  #
  # GET /campaign_completed_stages
  def index
    @campaign_completed_stages = CampaignCompletedStage.order('completed_percentage').page(params[:page])
   
    respond_to do |format|
      format.html  # index.html.erb
    end
  end
  
  ##
  # Render a page to create new CampaignCompletedStage
  #
  def new
    @campaign_completed_stage = CampaignCompletedStage.new
    
    respond_to do |format|
      format.html  # new.html.erb
    end
  end
  
  ##
  # Process to insert a new CampaignCompletedStage into the DataBase
  #
  def create
    @campaign_completed_stage = CampaignCompletedStage.new(params[:campaign_completed_stage])
    @campaign_completed_stage.created_by = current_user.id

    respond_to do |format|
      if @campaign_completed_stage.save
        format.html  { redirect_to campaign_completed_stages_path, :notice => "Le niveau d'avancement de la campagne a été créé." }
      else
        format.html  { render :action => "new" }
      end
    end
  end
  
  
  def edit
    @campaign_completed_stage = CampaignCompletedStage.find(params[:id])
  end
  
  ##
  # Process that udpate an existing CampaignCompletedStage
  #
  def update
    @campaign_completed_stage = CampaignCompletedStage.find(params[:id])
    @campaign_completed_stage.modified_by = current_user.id

    respond_to do |format|
      if @campaign_completed_stage.update_attributes(params[:campaign_completed_stage])
        format.html  { redirect_to(campaign_completed_stages_url, :notice => "Le niveau d'avancement de la campagne a été mise à jour.") }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end
  
  ##
  # Process that remove an CampaignCompletedStage from the DB
  #
  def destroy
    @campaign_completed_stage = CampaignCompletedStage.find(params[:id])
    @campaign_completed_stage.destroy
    respond_to do |format|
      format.html { redirect_to campaign_completed_stages_url }
    end
  end

end
