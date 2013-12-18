# encoding: utf-8

##
# This class represents a person defined by a forename, surname, phone number, fax
# number, email adress, a mobile phone number and a job. This person is linked 
# with an Account and has no one to infinite Tasks
# 
class Contact < ActiveRecord::Base
  
  resourcify
  
  has_many :tasks
  
  has_and_belongs_to_many :tags
  
  belongs_to :account
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  
  validate :valid
  
  paginates_per 10
  
  def valid
    if (self.surname.blank? && self.forename.blank?)
      self.errors.add(:contact, 'Un de ces deux champs doit être remplis: Prénom ou Nom')
    end
  end
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end

  ## 
  # Get the complete name of this person.
  #
  def full_name
    #"#{title} #{forename} #{UnicodeUtils.upcase(surname, I18n.locale)}"
    "#{forename} #{UnicodeUtils.upcase(surname, I18n.locale)}"
  end
  
  ##
  # Define the title fo the contact
  # Can be: M.|Mme
  #
  TITLES = ["M.", "Mme"]
  
  ##
  # Order by surname
  #
  scope :order_by_surname, :order => 'surname'
  
  ##
  # Get contacts by company
  # * *Args*
  #   +company+ An instance of Account
  #
  scope :by_company, lambda { |company| joins(:account).where("accounts.company LIKE UPPER(?)", company)unless company.blank? }
  scope :by_surname, lambda { |surname| where('surname LIKE ?', surname) unless surname.blank?}
  scope :by_forename, lambda { |forename| where('forename LIKE ?', forname) unless forename.blank? }
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }

  scope :by_accounts, lambda { |account| where("account_id IN (?)", account)unless account.blank? }
  scope :by_tags, lambda { |tags| joins(:tags).where("tags.id IN (?)", tags) unless tags.blank? }  
  scope :by_zip_account, lambda { |zip_account| joins(:account).where("account.zip LIKE ?", zip_account + '%') unless zip_account.blank? } 
  scope :by_country_account, lambda { |country_account| joins(:account).where("accounts.country" => country_account) unless country_account.blank? } 
  scope :by_category_account, lambda { |category_account| joins(:account).where("accounts.category IN (?)", category_account) unless category_account.blank? } 
  scope :by_origin_account, lambda { |origin_account| joins(:account).where("accounts.origin_id IN (?)", origin_account) unless origin_account.blank? } 
  scope :by_user_account, lambda { |user_account| joins(:account).where("accounts.user_id" => user_account) unless user_account.blank? } 

  
end
