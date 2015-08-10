class RemoveAttachmentFieldsFromTask < ActiveRecord::Migration
  def up
    # Récupération des tâches
    tasks = Task.all
    tasks.each do |task|
        if (!task.attach.blank?)
            attach = TaskAttachment.new
            attach.attach = task.attach
            task.task_attachments.push attach
        end
    end

    # Suppression des champs devenus inutiles
    change_table :tasks do |t|
        remove_attachment :tasks, :attach
    end
  end

  def down
    # Modification de la table 'tasks'
    change_table :tasks do |t|
        t.attachment :attach
    end

    # Recuperation des tâches
    tasks = Task.all
    tasks.each do |task|
        if (!task.task_attachments.blank?)
            task.task_attachments.each do |attachment|
                new_task = task.dup
                new_task.attach = attachment.attach
                new_task.save
            end
            task.destroy
        end
    end
  end
end
