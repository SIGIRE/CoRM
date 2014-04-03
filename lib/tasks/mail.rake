# encoding: utf-8	
namespace :mail do

  desc "TODO"
  task :get_mails => :environment do
    require 'rubygems'
    require 'mail'

    # Récupération de la connexion
    connection = WebmailConnection.first

    # Test de validité de la connexion
    state = WebmailConnection.check(connection)

    # Si la connexion est marquée comme active et est valide
    puts("Active connection : #{connection.active}")
    puts("Connection state : #{state}")

    mails = nil
    event_id = nil	
    if connection.active && state
      begin
        # Récupération des éléments de connexion
        Mail.defaults do
          retriever_method :pop3, :address => connection.server,
            :port		 => connection.port,
            :user_name 	 => connection.login,
            :password 	 => connection.password,
            :enable_ssl 	 => false

          # Récupération des mails
          mails = Mail.find_and_delete
          event_id = connection.type_event_id
        end
      rescue 
        puts("An error occured")
        return nil
      end
    end

    # Si on a récupéré des emails et un type d'évènement
    if (!mails.nil? and !event_id.nil?)

      mails.each do |mail|
        begin
          # The raise statement avoids spam.
          user_from = User.by_mail(mail.from).first
          raise "User not found" if user_from.nil?

          if (mail.to.length != 0)
            accounts_with_contacts = get_accounts_with_contacts_by_mails(mail.to)
            to_archive = false
          else
            accounts_with_contacts = {}
            to_archive = true
          end

          accounts_with_contacts.each { |account, contacts| create_event(account, contacts) }

        rescue Exception => e
          #  puts "Il y a eu une erreur de type #{e.class} avec un email"
          #  puts "#{e.backtrace.join("\n")}"
        end
      end

    end
  end

  desc "TODO"
  task :process_mails => :environment do
    puts("Traitement des emails")

    emails = Email.all
    emails.each do |email|
      if (email.check)
        email.convert
      end
    end
  end    

  def convert(text)
    return text.force_encoding('iso8859-1').encode('UTF-8')
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

  def create_event (account, contacts, mail)
    debugger
    contacts_full_names = contacts.map { |contact| "#{contact.name} #{contact.surname}" }
                                  .join(', ')

    event = Event.new
    event.date_begin = mail.date.strftime("%Y-%m-%d %H:%M:%S")
    event.date_end = mail.date.strftime("%Y-%m-%d %H:%M:%S")
    event.notes = "Sujet : #{mail.subject}\nAvec : #{contacts_full_names}\n\n#{retrieve_body(mail)}"
    event.created_by = user_from.id
    event.contact_id = contacts.first.id
    event.account_id = account.id
    event.event_type_id = event_id
    event.user_id = user_from.id

    attachments = retrieve_attachments(mail)
    unless attachments.nil?
      attachments.each do |attachment|
        attach = EventAttachment.new
        attach.attach = attachment
        event.event_attachments << attach
      end
    end

    event.save
  end

  def save_mail (mail)
    email = Email.new
    email.user_id = user.id
    email.to = destinataire
    email.object = mail.subject
    email.content = retrieve_body(mail)
    email.send_at = mail.date.strftime("%Y-%m-%d %H:%M:%S")
    email.contact_id = contact.id
    email.save

    attachments = retrieve_attachments(mail)
    if (!attachments.nil?)
      attachments.each do |attachment|
        attach = EmailAttachment.new
        attach.attach = attachment
        email.email_attachments << attach
      end
    end
  end

  # Get mail adresses list as parameter :
  # ['foo@bar.com', 'titi@tata.fr']
  def get_accounts_with_contacts_by_mails(mails)
    resultset = Hash.new { |h, k| h[k] = Set.new }
    mails.each do |mail|
      contact = Contact.by_email(mail).first
      account = contact.account
      resultset[account].add(contact) unless account.nil?
    end

    return resultset
  end

  def retrieve_attachments(mail)
    # On vérifie la présence de pièces-jointes
    if (mail.attachments.length >= 1)
      puts("Cet email a #{mail.attachments.length} pieces jointes")
      array = []
      i = 1
      mail.attachments.each do |attachment|
        puts("Attachment n. #{i} - #{attachment.filename} (#{attachment.mime_type})")
        file = StringIO.new(attachment.decoded)
        file.class.class_eval { attr_accessor :original_filename, :content_type }
        file.original_filename = attachment.filename
        file.content_type = attachment.mime_type
        array.push file
        i = i+1
      end

      return array
    else
      puts("Cet email n'a pas de piece-jointe!")
      return nil
    end
  end

end
