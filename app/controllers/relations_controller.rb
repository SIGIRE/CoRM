# encoding: utf-8

##
# Controller that manages Relation
#
class RelationsController < ApplicationController
  
  before_filter :authenticate_user!

  ##
  # Render the page to show the form to create a new Relation
  #
  def new
    @relation = Relation.new
    @relation.account1_id = params[:account1_id]
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @relation }
    end
  end
  
  ##
  # Process to create a new Relation
  #
  def create
    @relation = Relation.new(params[:relation])   
    
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
    @relation = Relation.find(params[:id])
  end
  
  ##
  # Process to update a Relation
  #
  def update
    @relation = Relation.find(params[:id])
    
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
    @relation = Relation.find(params[:id])
    @relation.destroy
   
    respond_to do |format|
      format.html { redirect_to account_events_url(@relation.account1_id) }
      format.json { head :no_content }
    end
  end
end
