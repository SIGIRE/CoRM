##
# this class represent an import in csv file which can be accounts or contacts
# an origin must specified

class Import < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :origin
end
