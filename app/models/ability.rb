class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    else
      # General roles
      can :manage, Task
      can :manage, Account
      can :manage, Contact
      can :manage, Event
      can :manage, Relation
      can :manage, Opportunity
      can :manage, Quotation
      can :manage, QuotationLine
      if user.has_role? :super_user
        # Only super_user can manage settings
        can :manage, QuotationTemplate
        can :manage, Tag
        can :manage, Origin
        can :manage, EventType
        can [:read, :edit], User
      else
        can :read, QuotationTemplate
        can :read, Tag
        can :read, Origin
        can :read, EventType
        cannot :write, QuotationTemplate
        cannot :write, Tag
        cannot :write, Origin
        cannot :write, EventType
        can [:read, :update], User do |u|
            u.id == current_user.id
        end
        cannot [:create, :destroy], User
      end
      
    end
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
