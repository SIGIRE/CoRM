# encoding: utf-8

##
# Controller that manages Relation
#
class RelationsController < ApplicationController
  before_filter :load_account, only: [:index, :filter]
  layout :current_layout

  def index
    @relations = relations.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render :json => @relations }
    end
  end
  ##
  # Render the page to show the form to create a new Relation
  #
  def new
    if @ability.cannot? :create, Relation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Relation'))
      redirect_to account_events_url(@relation.account1_id)
	  return false
    end
    @relation = Relation.new
    @relation.account1_id = params[:account_id_1]
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @relation }
    end
  end
  
  ##
  # Process to create a new Relation
  #
  def create
    if @ability.cannot? :create, Relation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.create')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Relation'))
      redirect_to account_events_url(@relation.account1_id)
	  return false
    end
    @relation = Relation.new(params[:relation])   
    @relation.created_by = current_user.id
    respond_to do |format|
      if @relation.save
        format.html  { redirect_to account_events_url(@relation.account1_id), :notice => "La relation a été créée" }
        format.json  { render :json => @relation,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @relation.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Render the page to edit an existing Relation
  #
  def edit
    if @ability.cannot? :update, Relation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Relation'))
      redirect_to account_events_url(@relation.account1_id)
	  return false
    end
    @relation = Relation.find(params[:id])
  end
  
  ##
  # Process to update a Relation
  #
  def update
    if @ability.cannot? :update, Relation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.update')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Relation'))
      redirect_to account_events_url(@relation.account1_id)
	  return false
    end
    @relation = Relation.find(params[:id])
    @relation.updated_by = current_user.id    
    respond_to do |format|
      if @relation.update_attributes(params[:relation])
        format.html  { redirect_to account_events_url(@relation.account1_id), :notice => "La relation a été mise à jour." }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Process to delete an existing Relation from the Database
  #
  def destroy
    if @ability.cannot? :destroy, Relation
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.destroy')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Relation'))
      redirect_to account_events_url(@relation.account1_id)
	  return false
    end
    @relation = Relation.find(params[:id])
    @relation.destroy
   
    respond_to do |format|
      format.html { redirect_to account_events_url(@relation.account1_id), :notice => "La relation a bien été supprimée."  }
      format.json { head :no_content }
    end
  end

  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end
    
    def relations
      @account ? @account.relations : Relation
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
end
