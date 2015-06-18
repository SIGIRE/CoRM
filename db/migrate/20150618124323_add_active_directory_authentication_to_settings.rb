class AddActiveDirectoryAuthenticationToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :ad_enabled, :boolean
    add_column :settings, :ad_host, :string
    add_column :settings, :ad_port, :string, :default => '389'
    add_column :settings, :ad_domain, :string
  end
end
