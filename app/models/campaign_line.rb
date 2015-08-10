##
# This class represents lines of a marketing campaign.
# It can contains account_id, contact_id, last_action_date, notes, completed_percentage, result_percentage.
# It can be, for example, account_id: 12, contact_id: nil, last_action_date: '2015-01-31 14:28:00', notes: 'does not accept call after 20:00', completed_percentage: 20, result_percentage: 0
#
class CampaignLine < ActiveRecord::Base

  resourcify

  validates :name, uniqueness: true

  belongs_to :campaign, :contact, :account

  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'

  paginates_per 10

  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end

end