# encoding: utf-8


class Setting < ActiveRecord::Base
    has_attached_file :attach, :default_url => "/images/normal/logo-login.png"
    validates_attachment_content_type :attach, :content_type => /\Aimage\/.*\Z/
    
    def self.display_opportunities?
        setting = Setting.all.first
        setting.opportunities_display  
    end
    
    def self.display_quotations?
        setting = Setting.all.first
        setting.quotations_display  
    end
    
    def self.display_contracts?
        setting = Setting.all.first
        setting.contracts_display  
    end
    
    def self.display_business_menu?
        self.display_opportunities? || self.display_quotations? || self.display_contracts? 
    end
    
end
