#encoding: utf-8

#this class represent an account imported by a csv file and waiting for valitation

require 'text'

class ImportAccount < ActiveRecord::Base
  extend ToCsv
  resourcify
  
  CATEGORIES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire', 'Adhérent', 'Autre']
  ANOMALIES = {:duplicate=>'Doublon détecté dans l\'import',:duplicate_in_db=>'Doublon détecté dans la base', :company_name=>'Nom Société incorrect',:category=>'Catégorie incorrecte',:no=>'-'}
  
  paginates_per 30
  
  before_save :uppercase_company
  
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :import
  belongs_to :origin
  
  # Help to sort by account in error
  #scope :invalid, -> anomaly { where("anomaly != '#{ImportAccount::ANOMALIES[:no]}'") }
  scope :anomaly, lambda { |a| where("anomaly IN (?)", a) unless a.blank? }
  
  
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
        anomaly=ImportAccount::ANOMALIES[:no]
        #search anomaly on company name
        #if company is nil or invalid characters
        if account.company.blank? || account.company[/\w/]==nil
            anomaly=ImportAccount::ANOMALIES[:company_name]
        else
            #search duplicate account
            #try to match with imported accounts except account itself
            if account.no_search_duplicates==false
                ImportAccount.find_each(:conditions => "id != #{account.id} AND company !='' AND no_search_duplicates=false") do |account2|            
                  if is_match(account, account2)
                    anomaly=ImportAccount::ANOMALIES[:duplicate]
                    if account2.anomaly!=ImportAccount::ANOMALIES[:duplicate]
                        account2.update_attributes(:anomaly=>ImportAccount::ANOMALIES[:duplicate])
                    end
                  end               
                end
                
                #try to match with accounts
                if account.no_search_duplicates==false
                    Account.find_each do |account2|            
                        if is_match(account, account2)
                          anomaly=ImportAccount::ANOMALIES[:duplicate_in_db]+" :"+account2.company
                        end               
                    end
                end
                
                
            end
        end 
        
        #search anomaly on category
        if !(ImportAccount::CATEGORIES).include?("#{account.category}") #if category not in authorizes values
            anomaly=ImportAccount::ANOMALIES[:category]
        end     
        account.update_attributes(:anomaly => anomaly)
    end
    
    #this method match 2 accounts and return true if they seems duplicates
    def self.is_match (account1,account2)
        match=false
        #try to match phone in priority
        if !account1.tel.blank? &&
            !account2.tel.blank? &&
            !account1.tel=~/\d/ &&
            !account2.tel=~/\d/ &&
            account1.tel.gsub(/[^0-9]/,"").eql?(account2.tel.gsub(/[^0-9]/,""))
          match=true
          
        else #try to match company name AND zip if both zip exist else try to match only company name                    

            score=Text::WhiteSimilarity.new

            if !account1.zip==nil? && !account2.zip==nil?
                company1=account1.company.upcase
                company2=account2.company.upcase
                
                #use gem Text : if score = 1 similarity is total                
                if score.similarity(company1,company2)>0.7 && account1.zip.gsub(/\s/,"").eql?(account2.zip.gsub(/\s/,""))
                    match=true                
                end
            else
                if score.similarity(company1,company2)>0.8
                    match=true                
                end              
            end
        end
        return match
    end
 
end
