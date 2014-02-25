class RemoveAttachmentFieldsFromEvent < ActiveRecord::Migration
  def up
    # Récupération des évènements
    events = Event.all
    events.each do |event|
        if (!event.attach.blank?)
            attach = EventAttachment.new
            attach.attach = event.attach
            event.event_attachments.push attach
        end
    end
    
    # Suppression des champs devenus inutiles
    change_table :events do |t|
        remove_attachment :events, :attach
    end
  end

  def down
    # Modification de la table 'events'
    change_table :events do |t|
        t.attachment :attach
    end
    
    # Recuperation des évènements
    events = Event.all
    events.each do |event|
        if (!event.event_attachments.blank?)
            event.event_attachments.each do |attachment|
                new_event = event.clone
                new_event.attach = attachment.attach
                new_event.save
            end
            event.destroy
        end
    end
  end
end
