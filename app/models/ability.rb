class Ability

  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    # cannot register#all except #edit for him
    can [:edit, :show], User do |u|
      u.try(current_user) == user
    end
    # cannot settings do s(#all) except #show
    can :read, QuotationTemplate
    can :read, Tag
    can :read, Origin
    can :read, EventType
  
    if user.super_user?
      # can register#show --without disabled
      can [:show, :edit], User
      # can register#edit
      # can quotationTemplate#all
      can :manage, QuotationTemplate
      can :manage, Tag
      can :manage, Origin
      can :manage, EventType
      
      if user.admin?
        can :manage, :all
      end
    end
  end

end
