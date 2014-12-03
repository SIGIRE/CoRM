# encoding: utf-8
namespace :import do

desc "import accounts from txt file"
  task :comptes => :environment do
    require 'csv'
    CSV.foreach('accounts_MLV.txt', headers: true) do |row|
 
        Account.create row.to_hash
    end  
  end

desc "import contacts from txt file"
  task :contacts => :environment do
    require 'csv'
    CSV.foreach('contacts_MLV.txt', headers: true) do |row| 
        contact = Contact.create row.to_hash
        #compte = Account.select('id').where(accounting_code: (contact.account_id).to_s)
        
        compte = Account.find_by_accounting_code((contact.account_id).to_s)
        if !compte==nil?
          contact.update_attributes(:account_id => compte.id)
        end
    end
    
  end


  
  desc "search duplicates accounts"
  task :doublons_a => :environment do
    duplicates=Array.new
    no_match=["DE",
              "DES",
              "LA",
              "LE",
              "LES",
              "A",
              "AU",
              "AUX",
              "ET",
              "SA",
              "SARL",
              "SAS",
              "SCII",
              "ASSOCIATION",
              "MR",
              "MME",
              "FRANCE",
              "PARIS",
              "SERVICES",
              "LOCAL",
              "INTERIM",
              "INSTITUT"]

    Account.find_each do |account1|
      hash_company1=account1.company.upcase.gsub(".","").split

      Account.find_each(start: (account1.id)+1) do |account2|
        match=false
        hash_company2=account2.company.upcase.gsub(".","").split
        
        if !account1.tel==nil? && !account2.tel==nil? && account1.tel.gsub(/[^0-9]/,"") == account2.tel.gsub(/[^0-9]/,"")
          match=true
        else   
          hash_company2.each do |h|
            if !no_match.include?("#{h}")
              if hash_company1.include?("#{h}") && account1.zip==account2.zip
                match=true
              end
            end     
          end
        end
        
        if match
          duplicates.push("#{account1.id};#{account1.company};#{account1.full_adress};#{account1.tel}") unless duplicates.include?("#{account1.id};#{account1.company};#{account1.full_adress};#{account1.tel}")
          duplicates.push("#{account2.id};#{account2.company};#{account2.full_adress};#{account2.tel}") unless duplicates.include?("#{account2.id};#{account2.company};#{account2.full_adress};#{account2.tel}")
          #first_match=false
        end      
      end   
    end
    #puts duplicates.inspect
    # Create a new file and write to it  
    File.open('doublons_comptes.txt', 'w') do |f|  
    #use "\n" for two lines of text  
      duplicates.each do |line|
        f.puts line.to_s
      end
      
    end
  end

  desc "search duplicates contacts"
  task :doublons_c => :environment do
    duplicates=Array.new
    no_match=["MONSIEUR",
              "MADAME",
              "MR",
              "MME",
              "DE",
              "DU",
              "LES",
              "LE"]

    Contact.find_each do |contact1|
      if !contact1.nil?
        hash_surname1=contact1.surname.upcase.gsub(".","").split
      end
      
      
      
      Contact.find_each(start: (contact1.id)+1) do |contact2|
        match=false
        if !contact2.nil?
          hash_surname2=contact2.surname.upcase.gsub(".","").split
        end
        
        
        
        if !contact1.tel==nil? && !contact2.tel==nil? && contact1.tel.gsub(/[^0-9]/,"") == contact2.tel.gsub(/[^0-9]/,"")
          match=true
        else
          if !contact1.nil? && !contact2.nil?
            hash_surname2.each do |h|
              if !no_match.include?("#{h}")
                if hash_surname1.include?("#{h}")
                  match=true
                end
              end
            end
          end    
        end
        
        if match
          req_compte_assoc1=Account.find_by_id(contact1.account_id)
          if !req_compte_assoc1==nil?
            compte_assoc1=req_compte_assoc1.company
          end
          req_compte_assoc2=Account.find_by_id(contact2.account_id)
          if !req_compte_assoc2==nil?
            compte_assoc2=req_compte_assoc2.company
          end
          duplicates.push("#{contact1.id};#{contact1.surname};#{contact1.forename};#{contact1.tel};#{compte_assoc1}") unless duplicates.include?("#{contact1.id};#{contact1.surname};#{contact1.forename};#{contact1.tel};#{compte_assoc1}")
          duplicates.push("#{contact2.id};#{contact2.surname};#{contact2.forename};#{contact2.tel};#{compte_assoc2}") unless duplicates.include?("#{contact2.id};#{contact2.surname};#{contact2.forename};#{contact2.tel};#{compte_assoc2}")
        end      
      end   
    end
    #puts duplicates.inspect
    File.open('doublons_contacts.txt', 'w') do |f|  
    #use "\n" for two lines of text  
      duplicates.each do |line|
        f.puts line.to_s
      end
      
    end
  end

end