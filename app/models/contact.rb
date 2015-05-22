# encoding: utf-8

##
# This class represents a person defined by a forename, surname, phone number, fax
# number, email adress, a mobile phone number and a job. This person is linked 
# with an Account and has no one to infinite Tasks
# 
class Contact < ActiveRecord::Base

  extend ToCsv
  resourcify
  
  #has_many is added because import_contact has a contact_id column to store id of duplicate account
  has_many :import_contact
  
  has_many :tasks
  has_many :aliases, dependent: :destroy

  has_and_belongs_to_many :tags
  
  belongs_to :account
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :import
  
  accepts_nested_attributes_for :aliases, allow_destroy: true
  
  paginates_per 10
    
  validate :valid
  validates :account, :presence => true, if: :mandatory_account_setting?
  
  def valid
    if (self.surname.blank? && self.forename.blank?)
      self.errors.add(:contact, 'Un de ces deux champs doit être remplis: Prénom ou Nom')
    end
  end
  
  def mandatory_account_setting?
    @setting = Setting.all.first
    @setting.mandatory_account
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
  # Sets alias mails of current Contact, taking an array of strings as parameter.

  def set_aliases_from_array emails_array
    aliases.each { |m_alias| m_alias.destroy unless emails_array.include? m_alias.email }
    emails_array.each { |email| aliases.push Alias.new(email: email) unless has_alias? email }
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << (self.column_names + Account.column_names)
      all.each do |contact|
        if contact.account.blank?
          csv << (contact.attributes.values_at(*self.column_names))
        else
          csv << (contact.attributes.values_at(*self.column_names) + contact.account.attributes.values_at(*Account.column_names) )          
        end
      end
    end
  end

  ##
  # Checks if the User has the mail adress as an alias.
  # Takes string mail adress as a parameter.

  def has_alias? mail_alias
    aliases.any? { |mail| mail == mail_alias }
  end

  ##
  # Define the title fo the contact
  # Can be: M.|Mme
  #
  TITLES = ["M.", "Mme"]
  
  scope :order_by_surname, :order => 'surname'
  scope :by_account_company_like, lambda { |company| joins(:account).where("accounts.company LIKE UPPER(?)", "#{company}%") unless company.blank? }
  scope :by_account_id, lambda { |account_id| where(account_id: account_id) }
  scope :by_surname, lambda { |surname| where('surname LIKE ?', surname) unless surname.blank?}
  scope :by_forename, lambda { |forename| where('forename LIKE ?', forname) unless forename.blank? }
  scope :by_tel_like, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }
  scope :by_email, lambda { |email| includes(:aliases).where('UPPER(contacts.email) LIKE UPPER(?) OR UPPER(aliases.email) LIKE UPPER(?)', email, email) unless email.blank? }
  scope :by_accounts, lambda { |account| where("account_id IN (?)", account)unless account.blank? }
  scope :by_tags, lambda { |tags| joins(:tags).where("tags.id IN (?)", tags) unless tags.blank? }
  scope :by_account_tags, lambda { |tags| joins(:account => :tags).where("tags.id IN (?)", tags) unless tags.blank? }
  scope :by_zip_account, lambda { |zip_account| joins(:account).where("accounts.zip LIKE ?", zip_account + '%') unless zip_account.blank? } 
  scope :by_country_account, lambda { |country_account| joins(:account).where("accounts.country" => country_account) unless country_account.blank? } 
  scope :by_category_account, lambda { |category_account| joins(:account).where("accounts.category IN (?)", category_account) unless category_account.blank? } 
  scope :by_origin_account, lambda { |origin_account| joins(:account).where("accounts.origin_id IN (?)", origin_account) unless origin_account.blank? } 
  scope :by_user_account, lambda { |user_account| joins(:account).where("accounts.user_id" => user_account) unless user_account.blank? } 
  scope :by_full_name_like, (lambda do |full_name|
    unless full_name.blank?
      where("(UPPER(contacts.surname || ' ' || contacts.forename)) LIKE UPPER(?) OR
             (UPPER(contacts.forename || ' ' || contacts.surname)) LIKE UPPER(?)",
            "%#{full_name}%",
            "%#{full_name}%"
           )
    end
  end)
  scope :active, lambda { where(active: true) }
  scope :inactive, lambda { where(active: false) }
  scope :none, lambda { where('1 = 0') }
  scope :by_import_id, lambda {|import| joins(:import).where('import_id = ?', import) unless import.nil?}
  
  scope :by_job_like, (lambda do |job|
    unless job.blank?
      where("UPPER(contacts.job) LIKE UPPER(?)", "%#{job}%")
    end
  end)
  scope :by_activity_account, lambda { |activity_account| joins(:account).where("accounts.activity_id IN (?)", activity_account) unless activity_account.blank? } 

  
  
  
  
  
end
