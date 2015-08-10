class RemoveAttachmentFieldsFromOpportunity < ActiveRecord::Migration
  def up
    # Récupération des opportunity
    opportunities = Opportunity.all
    opportunities.each do |opportunity|
        if (!opportunity.attach.blank?)
            attach = OpportunityAttachment.new
            attach.attach = opportunity.attach
            opportunity.opportunity_attachments.push attach
        end
    end

    # Suppression des champs devenus inutiles
    change_table :opportunities do |t|
        remove_attachment :opportunities, :attach
    end
  end

  def down
    # Modification de la table 'opportunities'
    change_table :opportunities do |t|
        t.attachment :attach
    end

    # Recuperation des évènements
    opportunities = Opportunity.all
    opportunities.each do |opportunity|
        if (!opportunity.opportunity_attachments.blank?)
            opportunity.opportunity_attachments.each do |attachment|
                new_opportunity = opportunity.clone
                new_opportunity.attach = attachment.attach
                new_opportunity.save
            end
            opportunity.destroy
        end
    end
  end
end
