# encoding: utf-8

##
# This class represents the final user, so he has many business, events or tasks as he wants.
# He defined by an email and a password at least, he can have also a forename, a surname, a phone number and a mobile phone number.
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :database_authenticatable, :ldap_authenticatable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  rolify

  has_many :accounts
  has_many :events
  has_many :tasks
  has_many :emails

  # nécessaire pour pouvoir modifer la valeur de ces attributs par nos propres forms
  attr_accessible :login_name, :email, :password, :password_confirmation, :remember_me, :forename, :surname, :tel, :mobile, :current_password, :enabled, :locale
  attr_accessor :current_password


  def self.default
     return User.new({:email => '', :forename => 'Neant', :surname => ''})
  end

  ##
  # Get the full name of this User
  # * *Returns*    :
  #   - The full name as  String
  #
  def full_name
      "#{forename} #{UnicodeUtils.upcase(surname, I18n.locale)}"
  end

  ##
  # Get all real users of application (without disabled and admins)
  # * *Returns*    :
  #   - Array of Users
  #
  def self.all_reals
      admin = User.joins(:roles).where("roles.name = 'admin'").first()
      return User.where(:enabled => true).reject{|e| e.id == admin.id}
  end

scope :by_mail, lambda { |mail| where('UPPER(users.email) = UPPER(?)', mail) unless mail.blank? }
scope :by_login_name, lambda { |login_name| where('UPPER(users.login_name) = UPPER(?)', mail) unless login_name.blank? }

end
