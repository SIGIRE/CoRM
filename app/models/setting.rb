# encoding: utf-8


class Setting < ActiveRecord::Base
    has_attached_file :attach, :default_url => "/images/normal/logo-login.png"
    validates_attachment_content_type :attach, :content_type => /\Aimage\/.*\Z/
    
    def self.display_opportunities?
        setting = Setting.all.first
        setting.blank? ? true : setting.opportunities_display
    end
    
    def self.display_quotations?
        setting = Setting.all.first
        setting.blank? ? true : setting.quotations_display
    end
    
    def self.display_contracts?
        setting = Setting.all.first
        setting.blank? ? true : setting.contracts_display
    end
    
    def self.display_business_menu?
        self.display_opportunities? || self.display_quotations? || self.display_contracts? 
    end
    
    def self.ad_enabled?
        setting = Setting.all.first
         setting.blank? ? false : setting.ad_enabled
    end
    
    def self.ad_host_value
        setting = Setting.all.first
        setting.ad_host 
    end
    
    def self.ad_port_value
        setting = Setting.all.first
        setting.ad_port
    end
    
    def self.ad_domain_value
        setting = Setting.all.first
        setting.ad_domain 
    end    
    
end
