class Alias < ActiveRecord::Base
  belongs_to :contact
  validates :email, presence: true, uniqueness: true
end
