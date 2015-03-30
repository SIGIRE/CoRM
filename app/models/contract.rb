##
# This class represents an Contract.
# It can contains name and a description
# It can be, for example, name: 'at a fair' description: 'Met this person at the pudding fair'
#
class Contract < ActiveRecord::Base
  
  resourcify
 
  belongs_to :contract_category
  belongs_to :account
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'
  
  paginates_per 10
  
  def author
    return author_user || User::default
  end
  
  def editor
    return editor_user || User::default
  end


  scope :by_account, lambda { |account| where("account_id = ?", account.id) unless account.nil? }  
  scope :by_account_id, lambda { |account_id| where("account_id = ?", account_id) unless account_id.blank?}
  scope :by_account_company_like, (lambda do |account_company|
    unless account_company.blank?
      joins(:account).
      where("UPPER(accounts.company) LIKE UPPER(?)", account_company + '%')
    end
  end)  
  scope :by_description_like, lambda { |description| where("UPPER(contracts.description) LIKE UPPER(?)", "%#{description}%") unless description.blank? }
  scope :by_category_id, lambda { |contract_category_id| where("contracts.contract_category_id = ?", contract_category_id) unless contract_category_id.nil? }   
  
end