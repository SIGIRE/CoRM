class Email < ActiveRecord::Base
  serialize :to, Array
  serialize :cc, Array
  serialize :cci, Array
  attr_accessible :id, :content, :object, :send_at, :from, :to, :cc, :cci, :user_id, :email_attachments, :email_attachments_attributes, :event_type_id
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
  # Get mail adresses list as parameter : ['foo@bar.com', 'titi@tata.fr']

  def accounts_with_contacts
    resultset = Hash.new { |h, k| h[k] = Set.new }
    self.to.each do |mail_adress|
      contact = Contact.by_email(mail_adress).first
      unless contact.nil?
        account = contact.account
        resultset[account].add(contact) unless account.nil?
      end
    end
    return resultset
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
      event.notes =  "Sujet : #{self.subject}\n"
      event.notes += "To : #{generate_string_from_mails(self.to)}\n" unless self.to.nil? 
      event.notes += "CC : #{generate_string_from_mails(self.cc)}\n" unless self.cc.nil?
      event.notes += "\n#{self.content}"

      self.attachments.each do |attachment|
        debugger
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
