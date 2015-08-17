# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      # Role Admin
      can :manage, :all

    elsif user.has_role? :readonly_user
      can :read, :all
      can :search, Account
      cannot :manage, [Import, ImportAccount, ImportContact]

    elsif user.has_role? :restricted_user
      # Role Restricted User
      can :read, Account
      can :search, Account
      can :update, Account, :user_id => user.id
      can :create, Account
      cannot :destroy, Account
      can :read, Alias
      can :update, Alias, :user_id => user.id
      can :create, Account
      cannot :destroy, Account
      can :read, Tag
      can :read, Contact
      can :update, Contact, :account => {:user_id => user.id}
      can :create, Contact, :account => {:user_id => user.id}
      cannot :destroy, Contact
      can :read, Event
      can :update, Event, :user_id => user.id
      can :create, Event, :account => {:user_id => user.id}
      can :destroy, Event, :user_id => user.id
      can :read, Relation
      can :update, Relation, :account => {:user_id => user.id}
      can :create, Relation, :account => {:user_id => user.id}
      can :destroy, Relation, :account => {:user_id => user.id}
      can :manage, Opportunity
      can :manage, Contract
      cannot :destroy, Opportunity
      cannot :destroy, Contract
      can :manage, Quotation
      cannot :destroy, Quotation
      can :manage, QuotationLine
      can :manage, Document
      cannot :destroy, Document
      can :read, User
      can :manage, Task
      cannot :destroy, Task
      can :manage, Email
      cannot :destroy, Email
      cannot :manage, [Import, ImportAccount, ImportContact]
      can :read, PaymentMode
      can :read, PaymentTerm
      can :read, Campaign
      can :create, Campaign
      can :update, Campaign, :created_by => user.id
    elsif user.has_role? :user
      # Role User
      can :manage, Task
      cannot :destroy, Task do |task|
        task.user_id != user.id
      end
      can :manage, Email
      can :manage, Account
      cannot :destroy, Account
      can :manage, Contact
      cannot :destroy, Contact
      can :read, Event
      can :update, Event, :user_id => user.id
      can :create, Event
      can :destroy, Event, :user_id => user.id
      can :manage, Relation
      can :manage, Opportunity
      can :manage, Contract
      can :manage, Quotation
      can :manage, QuotationLine
      can :manage, Document
      can :manage, Campaign
      can :read, User
      can :read, QuotationTemplate
      can :read, Tag
      can :read, Origin
      can :read, Activity
      can :read, ContractCategory
      can :read, EventType
      can :read, PaymentMode
      can :read, PaymentTerm
      cannot :write, QuotationTemplate
      cannot :write, Tag
      cannot :write, Origin
      cannot :write, Activity
      cannot :write, ContractCategory
      cannot :write, EventType
      cannot :manage, [Import, ImportAccount, ImportContact]
      
      elsif user.has_role? :super_user
      # Role Super User
      can :manage, Task
      cannot :destroy, Task do |task|
        task.user_id != user.id
      end
      can :manage, Email
      can :manage, Account
      can :activate, Account
      can :deactivate, Account
      can :manage, Contact
      #cannot :destroy, Contact
      can :manage, Event
      can :manage, Relation
      can :manage, Opportunity
      can :manage, Contract
      can :manage, Quotation
      can :manage, QuotationLine
      can :manage, Document
      can :read, User
      can :manage, QuotationTemplate
      can :manage, Tag
      can :manage, Origin
      can :manage, Activity
      can :manage, CampaignCompletedStage
      can :manage, CampaignResultStage
      can :manage, ContractCategory
      can :manage, EventType
      # can   #index #show #update & #edit
      can :update, User
      # cannot  #new #create
      can :manage, [Import, ImportAccount, ImportContact]
      can :manage, PaymentMode
      can :manage, PaymentTerm
      can :manage, Campaign

    else
      # Role User by default
      can :manage, Task
      cannot :destroy, Task do |task|
        task.user_id != user.id
      end
      can :manage, Email
      can :manage, Account
      cannot :destroy, Account
      can :manage, Contact
      cannot :destroy, Contact
      can :read, Event
      can :update, Event, :user_id => user.id
      can :create, Event
      can :destroy, Event, :user_id => user.id
      can :manage, Relation
      can :manage, Opportunity
      can :manage, Contract
      can :manage, Quotation
      can :manage, QuotationLine
      can :manage, Document
      can :manage, Campaign
      can :read, User
      can :read, QuotationTemplate
      can :read, Tag
      can :read, Origin
      can :read, Activity
      can :read, ContractCategory
      can :read, EventType
      can :read, PaymentMode
      can :read, PaymentTerm
      cannot :write, QuotationTemplate
      cannot :write, Tag
      cannot :write, Origin
      cannot :write, Activity
      cannot :write, ContractCategory
      cannot :write, EventType
      cannot :manage, [Import, ImportAccount, ImportContact]
    end
  end

end
