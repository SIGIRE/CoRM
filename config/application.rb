#!/usr/bin/env ruby
# encoding utf-8

require File.expand_path('../boot', __FILE__)
require 'rails/all'


if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

require 'json'




class CORM_Object < Hash

    @@path = './config/CORM.json'

    def self.createObject(json_object, depth)
        
        o = depth == 0 ? CORM_Object.new : Hash.new
        json_object.each do |k, v|
            if (json_object[k].is_a? Hash)
                o[k.to_sym] = self.createObject(v, depth+1)
            else
                o[k.to_sym] = v[0] == ':' ? v[1..v.length].to_sym : v
            end
            
        end
        return o
    end

    def self.get
        if (!File.exists?(@@path))
            throw Exception.new('The file ./config/CORM.json does not exists')
        end
        corm_json_string = File.read(@@path)
        json_object = JSON.parse(corm_json_string);
        return self.createObject(json_object, 0)
    end

    def get_version
        version = self[:version].split(' ')
        versionsSplitted = version[0].split('.')
        return {
            major: versionsSplitted[0].to_i,
            minor: versionsSplitted[1].to_i,
            corrected: versionsSplitted[2].to_i,
            build: version[1]
        }
    end
    
    def set_version(o)
        version = self[:version].split(' ')
        versionsSplitted = version[0].split('.')
        if (!o[:build].nil?)
            version[1] = o[:build]
        end
        versionsSplitted[0] = o[:major]
        versionsSplitted[1] = o[:minor]
        versionsSplitted[2] = o[:corrected]
        self[:version] = versionsSplitted.join('.').concat(version[1])
    end
    
    def save
        json = self.to_json
        json_o = JSON.parse(json)
        json = JSON.pretty_generate(json_o)
        File.open(@@path, 'w') do |f|
            f.write(json)
        end
    end

end

CORM = CORM_Object.get

module Crm
  class Application < Rails::Application
		
	config.to_prepare do
		Devise::SessionsController.layout "layout_for_sessions_controller"
		Devise::PasswordsController.layout "layout_for_sessions_controller" 
	end

    # default base url for links in mails
	config.action_mailer.default_url_options = { :host => CORM[:host] }
	# timezone of the app
    config.time_zone = 'Europe/Paris'
    # default locale is FR_fr. At this point (0.8.0), en.yml is not ready to use.
    config.i18n.default_locale = :fr
    config.i18n.locale = :fr
    # Configure the default encoding
    config.encoding = 'utf-8'
    # Add password to sensitive parameters
    config.filter_parameters += [:password]
    # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
