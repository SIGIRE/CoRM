##
# this class represent an import in csv file which can be accounts or contacts
# an origin must specified

class Import < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :accounts, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  
  paginates_per 10
  
end
