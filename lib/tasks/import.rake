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
        contact = Contact.create row.to_hash
        #compte = Account.select('id').where(accounting_code: (contact.account_id).to_s)
        
        compte = Account.find_by_accounting_code((contact.account_id).to_s)
        if !compte==nil?
          contact.update_attributes(:account_id => compte.id)
        end
    end
    
  end

end