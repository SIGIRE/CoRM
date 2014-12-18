#encoding: utf-8

#this class represent a contact imported by a csv file and waiting for valitation

require 'text'

class ImportContact < ActiveRecord::Base
  extend ToCsv
  resourcify
  
  ##
  # Define the title fo the contact
  # Can be: M.|Mme
  #
  TITLES = ["M.", "Mme"]
  ANOMALIES = {:duplicate=>'Doublon',:title=>'Civilité', :name=>'Nom Prénom',:no_account=>'Pas de compte correspondant',:no=>'Aucune'}
  
  paginates_per 30
  
  belongs_to :account
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :import
  
  # Help to sort by contacts in error
  #scope :invalid, -> anomaly { where("anomaly != '#{ImportContact::ANOMALIES[:no]}'") }
  scope :anomaly, lambda { |a| where("anomaly IN (?)", a) unless a.blank? }
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end

  ## 
  # Get the complete name of this person.
  #
  def full_name
    _forename='-'
    _surname='-'
    if !forename.blank?
      _forename=forename
    end
    if !surname.blank?
      _surname=surname
    end
    
    "#{_forename} #{UnicodeUtils.upcase(_surname, I18n.locale)}"
  end
  
  #
  # this metohd checked import_contact. If any invalid value, anomaly is set to type of anomaly
  # just one anomaly at a time. after each update import contact controller launch a new check
  # so, until anomaly doesn't exist, contact appear in red with a message in anomaly
  # column in index view
  #
  def self.checked_contact(contact)
    anomaly=ImportContact::ANOMALIES[:no]
    
    if contact.account_id.blank?
      #search in DB if an account with company name like company name of the contact exist
      compte = Account.find_by_company(contact.company.upcase) unless contact.company.blank?
      if compte.nil?
          anomaly=ImportContact::ANOMALIES[:no_account]
      else
          contact.update_attributes(:account_id=>compte.id)
      end
    end
    
    #if surname and forename are nil
    if contact.surname.blank? && contact.forename.blank?
      anomaly=ImportContact::ANOMALIES[:name]
    end
           
    #if surname or forname is nil or invalid characters
    if (!contact.surname.blank? && contact.surname[/\w/]==nil) || (!contact.forename.blank? && contact.forename[/\w/]==nil)
      anomaly=ImportContact::ANOMALIES[:name]
    
    #else search for duplicates (surname and forename equals)
    else
      #try to match with imported contacts except contact itself
      if contact.search_duplicates==true
        ImportContact.find_each(:conditions => "id != #{contact.id} AND search_duplicates=TRUE") do |contact2|            
          if is_match(contact, contact2)
            anomaly=ImportContact::ANOMALIES[:duplicate]
            if contact2.anomaly!=ImportAccount::ANOMALIES[:duplicate]
                contact2.update_attributes(:anomaly=>ImportAccount::ANOMALIES[:duplicate])
            end
          end               
        end  
      end
            
    end
    
    #if title is incorrect
    if contact.title!="M." && contact.title!="Mme"
      anomaly=ImportContact::ANOMALIES[:title]
    end
    
    contact.update_attributes(:anomaly => anomaly)
  end
    
    #
    #this method match 2 contacts and return true if they seems duplicates
    #
    def self.is_match (contact1,contact2)
        match=false
        #try to match phone and mobile in priority
        if !contact1.tel.blank? &&
            !contact2.tel.blank? &&
            !contact1.tel=~/\d/ &&
            !contact2.tel=~/\d/ &&
            contact1.tel.gsub(/[^0-9]/,"").eql?(contact2.tel.gsub(/[^0-9]/,""))
          match=true
        
        else
          if !contact1.mobile.blank? &&
              !contact2.mobile.blank? &&
              !contact1.mobile=~/\d/ &&
              !contact2.mobile=~/\d/ &&
              contact1.mobile.gsub(/[^0-9]/,"").eql?(contact2.mobile.gsub(/[^0-9]/,""))
            match=true
          
          else #try to match surnamename and forename                     
          
            if !contact1.surname.blank? && !contact1.forename.blank? && !contact2.surname.blank? && !contact2.forename.blank?
              #use gem Text
              surname1=contact1.surname.upcase
              forename1=contact1.forename.upcase
              surname2=contact2.surname.upcase
              forename2=contact2.forename.upcase
              score=Text::WhiteSimilarity.new
              if score.similarity(surname1,surname2)>0.7 && score.similarity(forename1,forename2)>0.7
                  match=true
              end
            end   
          end
        end
        return match
    end
end
