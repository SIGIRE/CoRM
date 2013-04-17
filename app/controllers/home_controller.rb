# encoding: utf-8

##
# Controller that manage About page
#
class HomeController < ApplicationController
  
  ##
  # About page
  #
  # GET /types
  # GET /types.json
  def index
    @page = params[:page]
    @tasks = Task.where("user_id =? AND statut IN ('En cours','A faire')", current_user.id).order("statut ASC ,priority ASC").limit(5) or nil
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end
