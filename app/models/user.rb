class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # nécessaire pour pouvoir modifer la valeur de ces attributs par nos propres forms
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nom, :prenom, :tel, :mobile, :current_password
  attr_accessor :current_password

  def nom_complet
    "#{prenom} #{nom}"
  end
  
  has_many :comptes
  has_many :evenements
  has_many :taches
end
