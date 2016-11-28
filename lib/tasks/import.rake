# encoding: utf-8
namespace :import do

  desc "Manually import accounts"
  task :accounts => :environment do
    require 'rubygems'
    require 'roo'
    puts '------------ BEGIN IMPORT:ACCOUNTS --------------------'
    xls = Roo::Spreadsheet.open('accounts.xlsx') # please, put the complete path of the file
    xls.default_sheet = xls.sheets[0]
    # This task uses the first line as column's title. Modify the titles if nedded
    lines = xls.parse(company: 'Nom', adress: 'Adresse', zip: 'Code postal', city: 'Ville', tel: 'Téléphone', fax: 'Fax', email: 'EMail', notes: 'Commentaires', web: 'Site internet')
    lines.each do |line|
      begin
        puts '------------ NEW LINE --------------------'
        if !line[:company].blank?
          i = 1.to_i
          company = nil
          adress1 = nil
          adress2 = nil
          zip = nil
          city = nil
          country = nil
          notes = nil
          tel = nil
          fax = nil
          email = nil
          web = nil
          created_by = nil
          user_id = nil
          
          company = line[:company].strip
                    
          line[:adress].lines.each do |adress_line|
            if i == 1
              adress1 = adress_line.chomp.strip
              if adress1.start_with?('"')
                adress1 = adress1[1..-1]
              end
              if adress1.end_with?('"')
                adress1 = adress1[0..-2]
              end
            elsif i == 2
              adress2 = adress_line.chomp.strip
              if adress2.start_with?('"')
                adress2 = adress2[1..-1]
              end
              if adress2.end_with?('"')
                adress2 = adress2[0..-2]
              end              
            end
            i += 1
          end
          
          zip = line[:zip].strip unless line[:zip].blank?
          city = line[:city].strip unless line[:city].blank?
          country = 'FRANCE'
          notes = line[:notes] unless line[:notes].blank?
          tel = line[:tel].strip unless line[:tel].blank?
          fax = line[:fax].strip unless line[:fax].blank?
          email = line[:email].strip unless line[:email].blank?
          web = line[:web].strip unless line[:web].blank?
          account_category_id = AccountCategory.where(:name => 'Suspect').pluck(:id).first.to_i
          created_by = User.where(:surname => 'My_Lastname', :forename => 'My_Forename').pluck(:id).first.to_i
          user_id = User.where(:surname => 'My_Lastname', :forename => 'My_Forename').pluck(:id).first.to_i
          
          puts "company = #{company}"
          puts "adress1 = #{adress1}"
          puts "adress2 = #{adress2}"
          puts "zip = #{zip}"
          puts "city = #{city}"
          puts "country = #{country}"
          puts "tel = #{tel}"
          puts "fax = #{fax}"
          puts "email = #{email}"
          puts "web = #{web}"
          puts "notes = #{notes}"
          puts "account_category_id = #{account_category_id}"
          puts "user_id = #{user_id}"
          puts "created_by = #{created_by}"
          
          account = Account.new(:company => company, :adress1 => adress1, :adress2 => adress2, :zip => zip, :city => city, :country => country, :notes => notes, :tel => tel, :fax => fax, :email => email, :web => web, :account_category_id => account_category_id, :created_by => created_by, :user_id => user_id)
          #account.save!
          puts '------------ LINE SAVE --------------------'
        end
      rescue => e
        puts e.backtrace
      end
    end
    puts '------------ END IMPORT:ACCOUNTS --------------------'
  end


end
