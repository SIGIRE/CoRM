class AddAttachmentFichierJointToTaches < ActiveRecord::Migration
  def self.up
    add_column :taches, :fichier_joint_file_name, :string
    add_column :taches, :fichier_joint_content_type, :string
    add_column :taches, :fichier_joint_file_size, :integer
    add_column :taches, :fichier_joint_updated_at, :datetime
  end

  def self.down
    remove_column :taches, :fichier_joint_file_name
    remove_column :taches, :fichier_joint_content_type
    remove_column :taches, :fichier_joint_file_size
    remove_column :taches, :fichier_joint_updated_at
  end
end
