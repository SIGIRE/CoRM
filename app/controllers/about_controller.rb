# encoding: utf-8

##
# Controller that manage About page
#
class AboutController < ApplicationController
  
  before_filter :authenticate_user!
  
  ##
  # About page
  #
  # GET /types
  # GET /types.json
  def index
  end
  
end
