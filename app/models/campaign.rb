# encoding: utf-8
##
# This class represents an marketing campaign.
# It can contains name, notes, date_begin, date_end, and an event_type_id.
# It can be, for example, name: 'E-mailing to promote my event', date_begin: '2015-01-01 14:00:00', date_end: '2015-01-31 12:00:00', event_type_id: 1
#
class Campaign < ActiveRecord::Base

  resourcify

  validates :name, uniqueness: true

  has_many :campaign_lines
  belongs_to :event_type
  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'modified_by', :class_name => 'User'

  paginates_per 10

  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end

end
