class TagsController < ApplicationController
  
  before_filter :authenticate_user!
  
  ##
  # Show the full list of Tags by pagination_by
  #
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.order('name').page(params[:page])
   
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
    @tag.created_by = current_user.full_name
    
    respond_to do |format|
      if @tag.save
        format.html  { redirect_to tags_path, :notice => 'Le Tag a ete cree' }
        format.json  { render :json => @tag,
                      :status => :created}
      else
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
    @tag.updated_by = current_user.full_name
   
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html  { redirect_to(tags_url, :notice => 'Le Tag a ete mis a jour.') }
        format.json  { head :no_content }
      else
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
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
  
end
