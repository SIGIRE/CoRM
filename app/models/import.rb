# encoding: utf-8

##
# this class represent an import in csv file which can be accounts or contacts
# an origin must specified

class Import < ActiveRecord::Base
    
  attr_accessible :name, :notes, :import_type, :category
  has_many :accounts, :dependent => :destroy
  has_many :import_accounts, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :import_contacts, :dependent => :destroy
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'
  
  CATEGORIES = ['Client', 'Suspect', 'Prospect', 'Fournisseur','Partenaire', 'Adhérent', 'Autre']
  
  paginates_per 10
  
  def author
    return author_user || User::default
  end
  
end
