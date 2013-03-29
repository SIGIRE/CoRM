
##
# This class represents the final user, so he has many business, events or tasks as he wants.
# He defined by an email and a password at least, he can have also a forename, a surname, a phone number and a mobile phone number.
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # nécessaire pour pouvoir modifer la valeur de ces attributs par nos propres forms
  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :tel, :mobile, :current_password
  attr_accessor :current_password

  @@default_user = User.new({:email => '', :forename => 'Neant', :surname => '' })

  def self.default
     return @@default_user
  end

  ##
  # Get the full name of this User
  # * *Returns*    :
  #   - The full name as  String
  #
  def full_name
      "#{forename} #{surname}"
  end
  
  has_many :accounts
  has_many :events
  has_many :tasks
end
