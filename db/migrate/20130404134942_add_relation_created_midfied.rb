class AddRelationCreatedMidfied < ActiveRecord::Migration
  def change
    add_column(:relations, 'created_by', :integer, { :null => true })
    add_column(:relations, 'updated_by', :integer, { :null => true })

    add_column(:quotation_templates, 'created_by', :integer, { :null => true })
    add_column(:quotation_templates, 'updated_by', :integer, { :null => true })
  end
end
