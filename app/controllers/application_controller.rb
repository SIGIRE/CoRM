# encoding: utf-8

##
# Main Controller (for protected pages)
#
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  before_filter :getAbility
  
  private
  def getAbility
    @ability = Ability.new(current_user)
  end
  
end
