class TaskAttachment < ActiveRecord::Base
    attr_accessible :task_id, :attach
    belongs_to :task
    has_attached_file :attach
end
