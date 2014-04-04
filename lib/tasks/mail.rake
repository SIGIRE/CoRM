# encoding: utf-8	
namespace :mail do

  desc "TODO"
  task :get_mails => :environment do
    require 'rubygems'
    require 'mail'
    require_relative '../../app/domain/mail_processor'

    connection = WebmailConnection.first
    mails = get_mails(connection)
    mp = MailProcessor.new
    mp.event_type_id = connection.type_event_id
    mails.each do |mail|
      begin
        mp.process(mail)
      rescue Exception => e
        puts e.backtrace
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

  def get_mails(connection)
    mails = nil
    begin
      Mail.defaults do
        retriever_method :pop3,
          { address: connection.server,
            port: connection.port,
            user_name: connection.login,
            password: connection.password,
            enable_ssl: false }
        mails = Mail.all
        #mails = Mail.find_and_delete
        event_id = connection.type_event_id
      end
    rescue 
      puts("An error occured")
    end
    return mails || []
  end

  def convert(text)
    return text.force_encoding('iso8859-1').encode('UTF-8')
  end

end
