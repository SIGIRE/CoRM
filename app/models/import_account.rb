#encoding: utf-8

#this class represent an account imported by a csv file and waiting for valitation

class ImportAccount < ActiveRecord::Base
  extend ToCsv
  resourcify
  
  CATEGORIES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire', 'Adhérent', 'Autre']
  
  paginates_per 30
  
  before_save :uppercase_company
  
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :import
  belongs_to :origin
  
  # Help to sort by account in error
  scope :invalid, -> anomaly { where("anomaly != '-'") }
  
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  def uppercase_company
    if !self.company.nil?
        UnicodeUtils.upcase(self.company, I18n.locale)
    end
   
  end

  def full_adress
	tmp = self.adress1
	if !tmp==nil? && !self.adress2.blank?
		tmp += ', ' + self.adress2
	end
	if !tmp==nil? && !self.zip.blank?
		tmp += ', ' + self.zip
	end
	if !tmp==nil? && !self.city.blank?
		tmp += ', ' + self.city
	end	
	return tmp
  end
  
    #this metohd checked import_account. If any invalid value, anomaly is set to type of anomaly
    def self.checked_account(account)
        anomaly='-'
        #search anomaly on company name
        #if company is nil or invalid characters
        if !account.company.nil?
            if account.company[/\w/]==nil 
                anomaly="Nom société"
            else
                #search duplicate account
                #try to match with imported accounts except account itself
                ImportAccount.find_each(:conditions => "id != #{account.id} AND company !=''") do |account2|            
                  if is_match(account, account2)
                    anomaly="Doublon"
                    if account2.anomaly!="Doublon"
                        account2.update_attributes(:anomaly=>"Doublon")
                    end
                  end               
                end
            end
        end 
        
        #search anomaly on category
        if !(ImportAccount::CATEGORIES).include?("#{account.category}") #if category not in authorizes values
            anomaly="Catégorie"
        end     
        account.update_attributes(:anomaly => anomaly)
    end
    
    #this method match 2 accounts and return true if they seems duplicates
    def self.is_match (account1,account2)
        match=false
        #try to match phone in priority
        if !account1.tel==nil? && !account2.tel==nil? && account1.tel.gsub(/[^0-9]/,"").eql?(account2.tel.gsub(/[^0-9]/,""))
          match=true
          
        else #try to match company name and zip                     
            #no test match if zip are empty          
          if !account1.zip==nil? && !account2.zip==nil?
            
            #don't try to match this words
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
                  
            #split in hash account1 and account2 company name
            #split with all non words characters and white space
            hash_company1=account1.company.upcase.gsub(/[^\w\s]/,"").split
            hash_company2=account2.company.upcase.gsub(/[^\w\s]/,"").split
            
            #delete no_match words from hashs
            hash_company1.delete_if{|w| no_match.include?("#{w}")}
            hash_company2.delete_if{|w| no_match.include?("#{w}")}
            
            nbr_match=0
            hash_company2.each do |h|
              #search for match if zip are equals
              if account1.zip.gsub(/\s/,"").eql?(account2.zip.gsub(/\s/,""))
                if hash_company1.include?("#{h}")
                    if  
                        nbr_match+=1            
                    end
                    #if all words of one of the two accounts are matchs, match is consider to be true
                    if hash_company1.length==nbr_match || hash_company2.length==nbr_match
                        match=true
                    end                  
                end
              end
            end
          end
        end
        return match
    end
 
end
