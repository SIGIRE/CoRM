class Relation < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :compte1, :class_name => 'Compte'
  belongs_to :compte2, :class_name => 'Compte'
  
  scope :by_compte, lambda { |compte| where("compte1_id = ? OR compte2_id = ?", compte.id, compte.id) unless compte.nil? }
end
