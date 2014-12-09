#encoding: utf-8

#this class represent a contact imported by a csv file and waiting for valitation

class ImportContact < ActiveRecord::Base
  extend ToCsv
  resourcify
  
  ##
  # Define the title fo the contact
  # Can be: M.|Mme
  #
  TITLES = ["M.", "Mme"]
  
  paginates_per 30
  
  belongs_to :account
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  belongs_to :import
  
  # Help to sort by contacts in error
  scope :invalid, -> anomaly { where("anomaly != '-'") }
  
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
    #"#{title} #{forename} #{UnicodeUtils.upcase(surname, I18n.locale)}"
    "#{forename} #{UnicodeUtils.upcase(surname, I18n.locale)}"
  end
  
  #this metohd checked import_account. If any invalid value, valid_account is turn to false
    def self.checked_contact(contact)
        anomaly='-'
        if contact.account_id.nil?        
          #search in DB if an account with company name like company name of the contact exist
          compte = Account.find_by_company(contact.company.upcase) unless contact.company.nil?
          if compte.nil?
              anomaly='pas de compte correspondant'
          else
              contact.account_id=compte.id
          end
        end
        #if surname or forname is nil or invalid characters
        if contact.surname[/\w/]==nil || contact.forename[/\w/]==nil 
            anomaly="Nom Prénom"
        end
        #if title is incorrect
        if !contact.title=="M." && !contact.title=="Mme"
          anomaly="Titre"
        end 
        contact.update_attributes(:anomaly => anomaly)
    end
  
end
