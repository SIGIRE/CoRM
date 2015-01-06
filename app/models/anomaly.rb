#encoding: utf-8

#this class represent an anomaly in imported datas (import_accounst or import_contacts)

class Anomaly < ActiveRecord::Base

  attr_accessible :level, :name, :notes
  
  has_many :import_accounts
  
  
end
