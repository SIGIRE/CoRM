# encoding: utf-8

##
# This class represents a Business. It's defined by a name, adress, ZIP code, 
# City, Country, Phone number, Fax number, email adress, website, accounting code.
# This is linked to an Origin
# The type is an enumerable (Customer, Prospect, ...)
# This business cas have many Contact, Event, Task, Document or Relation.
# Also, it belongs to one User and one Origin
#
class Account < ActiveRecord::Base
  
  resourcify
  
  before_save :uppercase_company
  
  has_many :contacts
  has_many :events
  has_many :tasks
  has_many :documents
  has_many :relations
  
  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :origin

  def new(attributes = nil, options = {})
	super(attributes, options)
  end

  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  paginates_per 10
  
  ##
  # TYPES represents the Account Type
  # It can have these values: Client|Suspect|Prospect|Fournisseur|Partenaire|Adherent|Autre
  #
  CATEGORIES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire', 'Adhérent', 'Autre']
  validates_inclusion_of :category, :in => CATEGORIES
  
  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :contacts
  
  # Help to sort by criteria
  scope :by_company, lambda { |company| where("company LIKE UPPER(?)", company)unless company.nil? }
  scope :by_contact, lambda {|contact| joins(:contacts).where('contacts.id = ?', contact.id) unless contact.nil?}
  scope :by_tel, lambda { |tel| where("tel LIKE ?", '%'+tel+'%') unless tel.blank? }
  scope :by_zip, lambda { |zip| where("zip LIKE ?", zip + '%') unless zip.blank? }
  scope :by_country, lambda { |country| where("country = ?", country) unless country.blank? }  
  scope :by_tags, lambda { |tags| joins(:tags).where("tags.id IN (?)", tags) unless tags.blank? }
  scope :by_user, lambda { |user| where("user_id = ?", user) unless user.blank? }
  scope :by_category, lambda { |cat| where("category IN (?)", cat) unless cat.blank? }   
  scope :by_origin, lambda { |origin| where("origin_id IN (?)", origin) unless origin.blank? }   
  
  ##
  # Set the business name to upper
  #
  def uppercase_company
    UnicodeUtils.upcase(self.company, I18n.locale)
  end

  def full_adress
	tmp = self.adress1
	if !self.adress2.blank?
		tmp += ', ' + self.adress2
	end
	if !self.zip.blank?
		tmp += ', ' + self.zip
	end
	if !self.city.blank?
		tmp += ', ' + self.city
	end	
	return tmp
  end
  
end
