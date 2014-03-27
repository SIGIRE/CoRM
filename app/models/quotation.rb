# encoding: utf-8

##
# This class represents an quotation so it defined by a reference, a build date, 
# validation date, status.
# It linked to an Opportunity, a Contact, a Account, User and a Template.
# It can have some status as: Saved|In Progress|Accepted|Refused
#
class Quotation < ActiveRecord::Base
  resourcify
  #attr_accessible :quotation_lines_attributes, :quotation_attachments, :quotation_attachments_attributes
  
  # Necessary to update fields with a nested form
  #attr_accessible :ref, :date, :account_id, :ref_account, :user_id, :validity, 
  # :mode_reg, :statut, :opportunity_id, :attach, :contact_id, :quotation_template_id,
  # :created_by, :updated_by, :label
  
  belongs_to :opportunity
  belongs_to :contact
  belongs_to :account
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  belongs_to :quotation_template
  
  paginates_per 10

  has_many :quotation_lines, :dependent => :destroy
  # We specify we access to each QuotationLines parameters from the Controller & the same for Quotation from Views
  accepts_nested_attributes_for :quotation_lines , :allow_destroy => true,
    :reject_if => lambda { |a| a[:ref].blank? || a[:quantity].blank? || a[:price_excl_tax].blank?}
  
    # Conservé pour le bon fonctionnement des migrations --> non utilisé
    has_attached_file :attach
  
    # Nouvelle gestion des pièces-jointes
    has_many :quotation_attachments, :dependent => :destroy
    accepts_nested_attributes_for :quotation_attachments
    alias_attribute :attachments, :quotation_attachments
  
  ##
  # Define the status of a Quotation
  # Available status are Saved|In progress|Accepted|Refused
  #
  STATUTS = ["Sauvegardé", "En cours", "Accepté", "Refusé"]

  monetize :total_excl_tax_cents
  monetize :total_VAT_cents
  monetize :total_incl_tax_cents

  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  def valid
    if self.quotation_lines.is_a?(Array) and self.quotation_lines.length > 0
      return ((self.quotation_lines.each {|line| if (!line.valid) then return false end }) == false ? false : true)
    else
      return false
    end
  end
  
  def self.last_modified(how_many = 10)
    self.order('updated_at DESC, created_at DESC').limit(how_many)
  end

  scope :by_statut, lambda { |statut| where("statut LIKE ?", statut+'%') }
  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }
  scope :by_user, lambda { |user| where("user_id = ?", user.id) unless user.nil? }
  scope :by_user_id, lambda { |user_id| where("user_id = ?", user_id) unless user.blank? }
end
