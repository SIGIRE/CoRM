## 
# This class aims to transform a Mail object (from mail gem) into an Email or an Event.
# 
# Once you have an instance of MailProcessor, you're supposed to give it an event_type_id
# _before_ processing any mail !

class MailProcessor
  attr_accessor :event_type_id

  ##
  # Transforms a mail into an event, or an Email instance if it can find any account
  # related to mail recipients.
  #
  # An exception will be raised if the instance of MailProcessor has no event_type_id set.

  def process(mail)
    raise "No event_type_id set" if event_type_id.blank?

    @mail = decompose(mail)

    begin
      raise "User not found" if @mail[:from].nil?
      @mail[:to].each { |account, contacts| create_event(account, contacts) }
      save_mail if @mail[:to].empty?

    rescue Exception => e
      puts "Error #{e.class} :\n#{e.backtrace.join("\n")}"
    end
  end


  #################################################################################
  private

  def decompose(mail)
    hash =
      { _mail: mail,
        subject: mail.subject,
        _to: mail.to,
        to: get_accounts_with_contacts_by_mails(mail.to),
        _cc: mail.cc,
        _from: mail.from,
        from: User.by_mail(mail.from).first,
        _date: mail.date,
        date: mail.date.strftime("%Y-%m-%d %H:%M:%S"),
        body: retrieve_body(mail),
        attachments: retrieve_attachments(mail) }
  end

  def retrieve_body(mail)
    begin
      text = ""
      encoding = ""
      # Si le mail est de type multipart
      if (mail.multipart?)
        puts "Multipart? => TRUE"
        mail.parts.each do |p|
          puts p.content_type
          if (p.content_type.include? "text/plain")
            text << "#{p.body}\n"
            encoding = p.content_type_parameters["charset"]
          elsif (p.content_type.include? "alternative")
            p.parts.each do |sub|
              if (sub.content_type.include? "text/plain")
                text << "#{sub.body}\n"
                encoding = sub.content_type_parameters["charset"]
              end
            end
          end
        end
        # Si le mail n'est pas de type multipart
      else
        text = mail.body.decoded
      end
      if (!encoding.blank?)
        text = text.force_encoding(encoding).encode('UTF-8')
      else
        if (text.force_encoding("UTF-8").encode('UTF-8').valid_encoding?)
          text = text.force_encoding("UTF-8").encode('UTF-8')
        elsif (text.force_encoding("iso-8859-1").encode('UTF-8').valid_encoding?)
          text = text.force_encoding("iso-8859-1").encode('UTF-8')
        end
      end
    rescue Exception => e
      puts e
      puts e.backtrace.join("\n")
      return nil
    else
      return text
    end
  end

  def create_event(account, contacts)

    contacts_full_names = contacts.map { |contact| "#{contact.forename} #{contact.surname}" }
                                  .join(', ')
    event = Event.new
    event.date_begin = @mail[:date]
    event.date_end = @mail[:date]
    event.notes =  "Sujet : #{@mail[:subject]}\n"
    event.notes += "To : #{generate_string_from_mails(@mail[:_to])}\n" unless @mail[:_to].nil? 
    event.notes += "CC : #{generate_string_from_mails(@mail[:_cc])}\n" unless @mail[:_cc].nil?
    event.notes += "\n#{@mail[:body]}"

    event.created_by = @mail[:from].id
    event.contact_id = contacts.first.id
    event.account_id = account.id
    event.event_type_id = self.event_type_id
    event.user_id = @mail[:from].id

    @mail[:attachments].each do |attachment|
      attach = EventAttachment.new
      attach.attach = attachment
      event.event_attachments << attach
    end

    event.save
  end

  def save_mail
    email = Email.new
    email.user_id = @mail[:from].id
    email.to = @mail[:_mail].to.first
    email.object = @mail[:subject]
    email.content = @mail[:body]
    email.send_at = @mail[:date]
    email.save

    @mail[:attachments].each do |attachment|
      attach = MailAttachment.new
      attach.attach = attachment
      email.mail_attachments << attach
    end
  end

  ##
  # Caches Contact.by_email results, avoids too many db queries

  def get_contact_by_mail(mail_adress)
    @contacts_cache ||= {}
    @contacts_cache[mail_adress] ||= Contact.by_email(mail_adress).first || 0
    
    return nil if @contacts_cache[mail_adress] == 0
    return @contacts_cache[mail_adress]
  end

  ##
  # Generates a string containing contacts fullname, if contact exists in db, or email adress
  # Get mail adresses list as parameter : ['foo@bar.com', 'titi@tata.fr']

  def generate_string_from_mails(mail_adresses)
    strings = []
    mail_adresses.each do |mail_adress|
      contact = get_contact_by_mail(mail_adress)
      strings.push(contact.nil? ? mail_adress : "#{contact.forename} #{contact.surname}")
    end
    return strings.join(', ')
  end

  ##
  # Generates a Hash whose keys are accounts and values sets of contacts.
  # Get mail adresses list as parameter : ['foo@bar.com', 'titi@tata.fr']

  def get_accounts_with_contacts_by_mails(mail_adresses)
    resultset = Hash.new { |h, k| h[k] = Set.new }
    mail_adresses.each do |mail_adress|
      contact = get_contact_by_mail(mail_adress)
      unless contact.nil?
        account = contact.account
        resultset[account].add(contact) unless account.nil?
      end
    end
    return resultset
  end

  def retrieve_attachments(mail)
    array = []
    mail.attachments.each do |attachment|
      file = StringIO.new(attachment.decoded)
      file.class.class_eval { attr_accessor :original_filename, :content_type }
      file.original_filename = attachment.filename
      file.content_type = attachment.mime_type
      array.push file
    end
    return array
  end

end
