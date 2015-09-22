##
# This class transform a mail into an Email instance, and try to convert it as an Event.
# If it's not possible, Email instance is saved in DB.
#
# Once you have an instance of MailProcessor, you're supposed to give it an event_type_id
# _before_ processing any mail !

class MailProcessor
  attr_accessor :event_type_id

  ##
  # Transforms a mail into Events, or an Email.
  # An exception will be raised if the instance of MailProcessor has no event_type_id set.

  def process(mail)
    raise "No event_type_id set" if event_type_id.blank?
    raise "Spam" if is_spam?(mail)

    email = convert_to_email(mail)
    # email.save should be replaced. At the moment, attached files (and so the mail) have to be saved for
    # the conversion to work. Seems like Paperclip cannot handle dirty active records instances.
    # I'd suggest we merge all *Attachments in one class, so we'll just have to pass the foreign key of
    # the attachment to the new Event when created.
    email.save
    if email.is_convertible_to_events?
      email.to_events.each do |event|
        event.save
      end
      email.destroy
    end
  end


  #################################################################################
  private

  def is_spam?(mail)
    User.by_mail(mail.from.first).empty?
  end

  def convert_to_email(mail)
    email = Email.new
    email.from = mail.from.to_a.first
    email.to = mail.to.to_a
    email.cc = mail.cc.to_a
    email.send_at = mail.date
    email.object = mail.subject
    email.content = retrieve_body(mail)
    email.attachments = retrieve_attachments(mail)
    email.event_type_id = event_type_id
    email.user_id = User.by_mail(mail.from).first.id

    return email
  end

  def retrieve_body(mail)
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
          puts p.body
        elsif (p.content_type.include? "text/html")
          encoding = p.content_type_parameters["charset"]
          text << Nokogiri::HTML(p.body.to_s, nil, encoding).text << "\n"
          puts p.body
        elsif (p.content_type.include? "alternative")
          p.parts.each do |sub|
            puts sub.content_type
            if (sub.content_type.include? "text/plain")
              text << "#{sub.body}\n"
              encoding = sub.content_type_parameters["charset"]
              puts sub.body
            elsif (sub.content_type.include? "text/html")
              encoding = sub.content_type_parameters["charset"]
              text << Nokogiri::HTML(sub.body.to_s, nil, encoding).text << "\n"
              puts sub.body
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
  rescue => e
    puts e
    puts e.backtrace.join("\n")
    return nil
  else
    return text
  end


  def retrieve_attachments(mail)
    array = []
    mail.attachments.each do |attachment|
      file = StringIO.new(attachment.decoded)
      file.class.class_eval { attr_accessor :original_filename, :content_type }
      file.original_filename = attachment.filename
      file.content_type = attachment.mime_type

      email_attachment = EmailAttachment.new
      email_attachment.attach = file
      array.push email_attachment
    end
    return array
  end

end
