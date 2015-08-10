# encoding: utf-8

##
# The Controller that manage CampaignResultStages
#
class CampaignResultStagesController < ApplicationController
  load_and_authorize_resource

  ##
  # Display the list of all CampaignResultStages by paginate_by
  #
  # GET /campaign_result_stages
  def index
    @campaign_result_stages = CampaignResultStage.order('result_percentage').page(params[:page])

    respond_to do |format|
      format.html  # index.html.erb
    end
  end

  ##
  # Render a page to create new CampaignResultStage
  #
  def new
    @campaign_result_stage = CampaignResultStage.new

    respond_to do |format|
      format.html  # new.html.erb
    end
  end

  ##
  # Process to insert a new CampaignResultStage into the DataBase
  #
  def create
    @campaign_result_stage = CampaignResultStage.new(params[:campaign_result_stage])
    @campaign_result_stage.created_by = current_user.id

    respond_to do |format|
      if @campaign_result_stage.save
        format.html  { redirect_to campaign_result_stages_path, :notice => "Le résultat de la campagne a été créé." }
      else
        format.html  { render :action => "new" }
      end
    end
  end


  def edit
    @campaign_result_stage = CampaignResultStage.find(params[:id])
  end

  ##
  # Process that udpate an existing CampaignResultStage
  #
  def update
    @campaign_result_stage = CampaignResultStage.find(params[:id])
    @campaign_result_stage.modified_by = current_user.id

    respond_to do |format|
      if @campaign_result_stage.update_attributes(params[:campaign_result_stage])
        format.html  { redirect_to(campaign_result_stages_url, :notice => "Le résultat de la campagne a été mise à jour.") }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
      end
    end
  end

  ##
  # Process that remove an CampaignResultStage from the DB
  #
  def destroy
    @campaign_result_stage = CampaignResultStage.find(params[:id])
    @campaign_result_stage.destroy
    respond_to do |format|
      format.html { redirect_to campaign_result_stages_url }
    end
  end

end
