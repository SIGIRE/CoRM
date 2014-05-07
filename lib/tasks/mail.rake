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
      rescue => e
        puts e.backtrace
      end
    end
  end

  desc "TODO"
  task :process_mails => :environment do
    emails = Email.all
    emails.each do |email|
      if email.is_convertible_to_events?
        email.to_events.each { |event| event.save }
        email.destroy
      end
    end
  end    

  def get_mails(connection)
    Mail.defaults do
      retriever_method :pop3,
        { address: connection.server,
          port: connection.port,
          user_name: connection.login,
          password: connection.password,
          enable_ssl: false }
      mails = Mail.find_and_delete
      event_id = connection.type_event_id
    end
  rescue 
    puts("An error occured")
  ensure
    mails ||= []
    return mails
  end

  def convert(text)
    return text.force_encoding('iso8859-1').encode('UTF-8')
  end

end
