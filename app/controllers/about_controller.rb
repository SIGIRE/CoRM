# encoding: utf-8

class AboutController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /types
  # GET /types.json
  def index
  end
  
end