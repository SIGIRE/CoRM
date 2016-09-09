#encoding: utf-8

class MailEventType < ActiveRecord::Base
  resourcify

  validates :pattern, uniqueness: true
  validates :event_type_id, presence: true

  belongs_to :event_type
  attr_accessible :name, :pattern, :event_type_id

  belongs_to :author_user, :foreign_key => 'created_by', :class_name => 'User'
  belongs_to :editor_user, :foreign_key => 'updated_by', :class_name => 'User'

  paginates_per 10

  def author
    return author_user || User::default
  end

  def editor
    return editor_user || User::default
  end
  
  # Returns the MailEventType found where its pattern is included in the test_string. If nothing found or more than one, returns nil
  def self.find_pattern(test_string)
    test_string = "#{test_string}" # be sure it is a String !
    found = 0
    @mail_event_type_found = nil
    
    MailEventType.each do |mail_event_type|
      if test_string.include?(mail_event_type.pattern)
        found += 1
        @mail_event_type_found = mail_event_type
      end
    end

    if found == 1 and !@mail_event_type_found.blank?
      @mail_event_type_found
    else
      nil
    end

  end

end
