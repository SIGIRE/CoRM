##
# This class represents a readable file.
# It belongs to Account
#
class Document < ActiveRecord::Base
  
  resourcify
  
  belongs_to :account
  belongs_to :user
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  paginates_per 10
  
    # Conservé pour le bon fonctionnement des migrations --> non utilisé
    has_attached_file :attach
      
    # Nouvelle gestion des pièces-jointes
    has_many :document_attachments, :dependent => :destroy
    accepts_nested_attributes_for :document_attachments, allow_destroy: true
    alias_attribute :attachments, :document_attachments
  
  validates :name,  :presence => true
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end
  
  scope :by_account, lambda { |account| where("account_id = ?", account.id )unless account.nil? }
end
