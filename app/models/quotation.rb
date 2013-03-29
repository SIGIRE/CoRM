# encoding: utf-8

##
# This class represents an quotation so it defined by a reference, a build date, 
# validation date, status.
# It linked to an Opportunity, a Contact, a Account, User and a Template.
# It can have some status as: Saved|In Progress|Accepted|Refused
#
class Quotation < ActiveRecord::Base
  
  attr_accessible :quotation_lines_attributes
  
  # Necessary to update fields with a nested form
  attr_accessible :ref, :date, :account_id, :ref_account, :user_id, :validity, 
    :mode_reg, :statut, :opportunity_id, :attach, :contact_id, :quotation_template_id,
    :created_by, :updated_by
  
  belongs_to :opportunity
  belongs_to :contact
  belongs_to :account
  belongs_to :user
  belongs_to :author, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor, :foreign_key => 'updated_by', :class_name => 'User'
  belongs_to :quotation_template
  
  has_many :quotation_lines, :dependent => :destroy
  # We specify we access to each QuotationLines parameters from the Controller & the same for Quotation from Views
  accepts_nested_attributes_for :quotation_lines , :allow_destroy => true,
    :reject_if => lambda { |a| a[:ref].blank? || a[:quantity].blank? || a[:price_excl_tax].blank?}
  
  has_attached_file :attach
  
  ##
  # Define the status of a Quotation
  # Available status are Saved|In progress|Accepted|Refused
  #
  STATUTS = ["Sauvegardé", "En cours", "Accepté", "Refusé"]

  monetize :total_excl_tax_cents
  monetize :total_VAT_cents
  monetize :total_incl_tax_cents


  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
end
