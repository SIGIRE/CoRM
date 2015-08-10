class ModifySettingsTable < ActiveRecord::Migration
  def up
    drop_table :settings

    create_table :settings do |t|
        t.attachment :attach
    end

    Setting.reset_column_information

    # Creation d'une nouvelle entree
    Setting.create
  end

  def down
    drop_table :settings

    # Creation de la table cle-valeur
    create_table :settings, {:id=>false} do |t|
      t.string :key
      t.string :value
      t.string :input_type
    end

    execute "ALTER TABLE settings ADD PRIMARY KEY (key)"

    # Creation d'une nouvelle entree
    setting = Setting.new
    setting.key = "logo_login"
    setting.save

  end
end
