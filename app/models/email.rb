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
    convert if is_convertible_to_events?
  end

  ##
  # Checks if self can be converted to an Event instance.

  def is_convertible_to_events?
    !accounts_with_contacts.empty?
  end

  ##
  # Generates a Hash whose keys are accounts and values sets of contacts.
  # Uses arbitrary 

  def accounts_with_contacts
    resultset = Hash.new { |h, k| h[k] = Set.new }
    self.to.each do |mail_adress|
      contact = Contact.by_email(mail_adress).first
      unless contact.nil?
        account = contact.account
        resultset[account].add(contact) unless account.nil?
      end
    end

    resultset[arbitrary_account].add(arbitrary_contact) if has_arbitrary_account_and_contact?
    return resultset
  end

  def has_arbitrary_account_and_contact?
    self.arbitrary_account && self.arbitrary_contact
  end

  ##
  # Returns an array populated with accounts related to TO field.

  def accounts
    accounts_with_contacts.keys
  end

  ##
  # Returns an array of contacts wich are associated with an account.

  def contacts
    resultset = []
    accounts_with_contacts.values.each do |contacts_set|
      contacts_set.each { |contact| resultset << contact }
    end
    resultset
  end

  private ##########################################################################

  ##
  # Creates and returns an array of Event from current Email instance.
  # There's one Event by identified account

  def convert
    events = []

    accounts_with_contacts.each do |account, contacts|
      event = Event.new
      event.account_id = account.id
      event.contact_id = contacts.first.id
      event.created_by = self.user_id
      event.user_id = self.user_id
      event.event_type_id = self.event_type_id

      event.date_begin = self.send_at
      event.date_end = self.send_at
      event.notes =  "Sujet : #{self.object}\n"
      event.notes += "To : #{generate_string_from_mails(self.to)}\n" unless self.to.nil? 
      event.notes += "CC : #{generate_string_from_mails(self.cc)}\n" unless self.cc.nil?
      event.notes += "\n#{self.content}"

      self.attachments.each do |attachment|
        attach = EventAttachment.new
        attach.attach = attachment.attach
        event.event_attachments.push attach
      end

      events.push event
    end

    return events
  end

  ##
  # Generates a string containing contacts fullname, if contact exists in db, or email adress
  # Get mail adresses list as parameter : ['foo@bar.com', 'titi@tata.fr']

  def generate_string_from_mails(mail_adresses)
    strings = []
    mail_adresses.each do |mail_adress|
      contact = Contact.by_email(mail_adress).first
      strings.push(contact.nil? ? mail_adress : "#{contact.forename} #{contact.surname}")
    end
    return strings.join(', ')
  end
end
