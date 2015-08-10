class CreateCampaigns < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.timestamp :date_begin
      t.timestamp :date_end
      t.string :name
      t.text :notes
      t.string :created_by
      t.string :modified_by

      t.timestamps

      t.references :event_type
    end
  end

  def down
    drop_table :campaigns
  end
end
