# encoding: utf-8

class TagsController < ApplicationController
  load_and_authorize_resource :account
  load_and_authorize_resource :tag, :through => :account
  before_filter :authenticate_user!
  before_filter :load_account, only: [:index, :filter]
  layout :current_layout

  ##
  # Show the full list of Tags by pagination_by
  #
  # GET /tags
  # GET /tags.json
  def index
    @tags = tags.order('name').page(params[:page])
   
    flash.now[:alert] = "Pas de tags !" if @tags.empty?

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @produits }
    end
  end
  
  ##
  # Show the page with the form to add a new Tag
  #
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @tag }
    end
  end
  
  ##
  # Process to create a new Tag into the DB
  #
  def create
    @tag = Tag.new(params[:tag])
    @tag.created_by = current_user.id

    respond_to do |format|
      if @tag.save
        format.html  { redirect_to tags_path, :notice => 'Le tag a été créé.' }
        format.json  { render :json => @tag,
          :status => :created}
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "new" }
        format.json  { render :json => @tag.errors,
          :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Dispay the page to show one occurence of Tag
  #
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @tag }
    end
  end
  
  ##
  # Display the page with the form to edit one occurence of Tag
  #
  def edit
    @tag = Tag.find(params[:id])
  end
  
  ##
  # Process to save one occurence of Tag which is already exists
  #
  def update
    @tag = Tag.find(params[:id])
    @tag.updated_by = current_user.id
    
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html  { redirect_to(tags_url, :notice => 'Le tag a été mis à jour.') }
        format.json  { head :no_content }
      else
        flash[:error] = t('app.save_undefined_error')
        format.html  { render :action => "edit" }
        format.json  { render :json => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  ##
  # Delete one occurence of Tag from the Database
  #
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    
    respond_to do |format|
      format.html { redirect_to tags_url, :notice => 'Le tag a bien été supprimé.' }
      format.json { head :no_content }
    end
  end
  
  private
    def load_account
      @account = Account.find_by_id(params[:account_id])
    end
    
    def tags
      @account ? @account.tags : Tag
    end

    def current_layout
      if @account && @account.persisted? && request.path_parameters[:action] == "index" # i prefer helper 'current_action'
        "accounts_show"
      else
        "application"
      end
    end
end
