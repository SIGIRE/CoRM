# encoding: utf-8
namespace :import do

desc "import accounts from txt file"
  task :comptes => :environment do
    require 'csv'
    CSV.foreach('comptes.txt', headers: true) do |row|
 
        Account.create row.to_hash
    end  
  end

desc "import contacts from txt file"
  task :contacts => :environment do
    require 'csv'
    CSV.foreach('contacts.txt', headers: true) do |row|
 
        Contact.create row.to_hash
    end  
  end

end