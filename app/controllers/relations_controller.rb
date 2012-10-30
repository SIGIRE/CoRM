# encoding: utf-8

class RelationsController < ApplicationController
  
  before_filter :authenticate_user!

  def new
    @relation = Relation.new
    @relation.compte1_id = params[:compte1_id]
    
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @relation }
    end
  end
  
  def create
    @relation = Relation.new(params[:relation])   
    
    respond_to do |format|
      if @relation.save
        format.html  { redirect_to compte_evenements_url(@relation.compte1_id), :notice => "La relation a été créée" }
        format.json  { render :json => @relation,
                      :status => :created}
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @relation.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @relation = Relation.find(params[:id])
  end
  
  def update
    @relation = Relation.find(params[:id])
    
    respond_to do |format|
      if @relation.update_attributes(params[:relation])
        format.html  { redirect_to compte_evenements_url(@relation.compte1_id), :notice => "La relation a été mise à jour." }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy
   
    respond_to do |format|
      format.html { redirect_to compte_evenements_url(@relation.compte1_id) }
      format.json { head :no_content }
    end
  end
end
