#!/usr/bin/env ruby
# encoding utf-8

require File.expand_path('../boot', __FILE__)
require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

require 'json'
require './config/CORM_Object.rb'

CORM = CORM_Object.get

module Crm
  class Application < Rails::Application
		
	config.to_prepare do
		Devise::SessionsController.layout "layout_for_sessions_controller"
		Devise::PasswordsController.layout "layout_for_sessions_controller" 
	end

  # Default https

    if (!(CORM[:mail][:type].is_a? Symbol))
        CORM[:mail][:type] = CORM[:mail][:type].to_sym
    end
    # default base url for links in mails
    protocol = !CORM[:protocol].blank? ? CORM[:protocol] : 'http'
    
	config.action_mailer.default_url_options = { 
	    :host => CORM[:host],
	    :protocol => protocol
	}
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
