class Role < ActiveRecord::Base
resourcify
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
  
  def self.list_all
    [[I18n.t('app.roles.user'), :user], [I18n.t('app.roles.restricted_user'), :restricted_user], [I18n.t('app.roles.admin'), :admin], [I18n.t('app.roles.super_user'), :super_user]]
  end
  
end
