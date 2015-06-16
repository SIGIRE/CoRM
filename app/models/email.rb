# encoding: utf-8

class Email < ActiveRecord::Base
  serialize :to, Array
  serialize :cc, Array
  serialize :cci, Array
  attr_accessible :id, :content, :object, :send_at, :from, :to, :cc, :cci, :user_id, :email_attachments, :email_attachments_attributes, :event_type_id, :arbitrary_contact, :arbitrary_account, :account_id, :contact_id
  belongs_to :arbitrary_contact, :class_name => Contact, :foreign_key => 'contact_id'
  belongs_to :arbitrary_account, :class_name => Account, :foreign_key => 'account_id'
  has_many :email_attachments, :dependent => :destroy
  alias_attribute :attachments, :email_attachments
  accepts_nested_attributes_for :email_attachments
  paginates_per 10

  ##
  # Returns an instance of Event if self is eligible to conversion.
  # Otherwise, returns nil.

  def to_events
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / to_events"
    logger.debug "-------------------"
    convert if is_convertible_to_events?
  end

  ##
  # Checks if self can be converted to an Event instance.

  def is_convertible_to_events?
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / convertible_to_events"
    logger.debug "-------------------"
    if (!accounts_with_contacts.empty? or !self.arbitrary_account.blank?)
      logger.debug "convertible = true"
      true
    else
      logger.debug "convertible = false"
      false
    end
  end

  ##
  # Generates a Hash whose keys are accounts and values sets of contacts.
  # Uses arbitrary 

  def accounts_with_contacts
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / accounts_with_contacts"
    logger.debug "-------------------"    
    resultset = Hash.new { |h, k| h[k] = Set.new }
    self.to.each do |mail_adress|
      contact = Contact.by_email(mail_adress).first
      unless contact.nil?
        account = contact.account
        resultset[account].add(contact) unless account.nil?
      end
    end
    logger.debug "resultset = #{resultset}"
    resultset
  end
  

  def has_arbitrary_account_and_contact?
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / has_arbitrary_account_and_contact"
    logger.debug "-------------------"
    self.arbitrary_account && self.arbitrary_contact
  end

  ##
  # Returns an array populated with accounts related to TO field.

  def accounts
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / accounts"
    logger.debug "-------------------"    
    accounts = accounts_with_contacts.keys
    accounts << arbitrary_account if arbitrary_account
    accounts
  end

  ##
  # Returns an array of contacts wich are associated with an account.

  def contacts
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / contacts"
    logger.debug "-------------------"    
    resultset = []
    accounts_with_contacts.values.each do |contacts_set|
      contacts_set.each { |contact| resultset << contact }
    end
    resultset << arbitrary_contact if arbitrary_contact
    logger.debug "resultset = #{resultset}"
    resultset
  end

  private ##########################################################################

  ##
  # Returns an array of Event from current Email instance.
  # There's one Event by identified account

  def convert
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / convert"
    logger.debug "-------------------"    
    events = []
    
    # add arbitrary_account and arbitrary_contact if exist (arbitrary is the value entered by user when the system does not know the account/contact)
    if has_arbitrary_account_and_contact?
      rs = Hash.new { |h, k| h[k] = Set.new }
      rs[self.arbitrary_account].add(self.arbitrary_contact)
      accounts_with_contacts.merge(rs).each { |account, contacts| events.push(create_event account, contacts) }
    else
      accounts_with_contacts.each { |account, contacts| events.push(create_event account, contacts) }
    end
    #if self.arbitrary_account
    #  puts "SECOND CONVERT CALLED"
    #  contacts = []
    #  contacts.push self.arbitrary_contact if self.arbitrary_contact
    #  events.push(create_event arbitrary_account, contacts)
    #end
    logger.debug "events = #{events}"
    events
  end

  ##
  # Returns an event from an Account and an array of Contact
  # for current Email instance.

  def create_event account, contacts
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / create_event"
    logger.debug "-------------------"        
    event = Event.new
    event.account_id = account.id
    event.contact_id = contacts.first.id unless contacts.empty?
    event.created_by = self.user_id
    event.user_id = self.user_id
    event.event_type_id = self.event_type_id

    event.date_begin = self.send_at
    event.date_end = self.send_at
    event.notes = ""
    event.notes += "Envoyé à : #{generate_string_from_mails(self.to)}" if self.to.length > 1 
    event.notes += " - " if (self.to.length > 1) && !(self.cc.empty?)
    event.notes += "Copie : #{generate_string_from_mails(self.cc)}\n" unless self.cc.empty?
    event.notes +=  "Sujet : #{self.object}\n\n" unless self.object.blank?
    event.notes += "#{self.content}"
    self.attachments.each do |attachment|
      attach = EventAttachment.new
      attach.attach = attachment.attach
      event.event_attachments.push attach
    end
    logger.debug "event = #{event}"
    event
  end

  ##
  # Generates a string containing contacts fullname, if contact exists in db, or email adress
  # Get mail adresses list as parameter : ['foo@bar.com', 'titi@tata.fr']

  def generate_string_from_mails(mail_adresses)
    logger.debug "-------------------"
    logger.debug "Entre dans models/email.rb / generate_strings_from_mail"
    logger.debug "-------------------"      
    strings = []
    mail_adresses.each do |mail_adress|
      contact = Contact.by_email(mail_adress).first
      strings.push(contact.nil? ? mail_adress : "#{contact.forename} #{contact.surname}")
    end
    logger.debug "strings = #{strings.join(', ')}"
    return strings.join(', ')
  end
end
