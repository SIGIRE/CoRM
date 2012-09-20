class AddAttachmentFichierJointToEvenements < ActiveRecord::Migration
  def self.up
    change_table :evenements do |t|
      t.has_attached_file :fichier_joint
    end
  end

  def self.down
    drop_attached_file :evenements, :fichier_joint
  end
end
