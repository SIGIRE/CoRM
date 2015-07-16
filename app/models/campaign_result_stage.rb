##
# This class represents an campaign_result_stage.
# It can contains name and a percentage's result.
# It can be, for example, name: 'Success' result_percentage: 100
#
class CampaignResultStage < ActiveRecord::Base

  resourcify

  validates :name, uniqueness: true

  has_many :campaign_lines
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