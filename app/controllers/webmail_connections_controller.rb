class WebmailConnectionsController < ApplicationController

  def update
	@webmail_connection = WebmailConnection.find(params[:webmail_connection][:id])
	if @webmail_connection.update_attributes(params[:webmail_connection])
		redirect_to :controller => "settings", :action => 'index'
	else
		redirect_to :controller => "settings", :action => 'index'
	end
  end

  def index
		if current_user.has_role?(:admin)
            @webmail_connections = WebmailConnection.first
		else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Settings'))
			redirect_to root_url
			return false
		end
  end
	
	def edit
		if current_user.has_role?(:admin)
      @webmail_connection = WebmailConnection.first
			render "edit", :locals => {:webmail_connection => @webmail_connection}
		else
			flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.do')).gsub('[undefined_article]', t('app.default.undefine_article_female')).gsub('[model]', t('app.controllers.Settings'))
			redirect_to root_url
			return false
		end
	end
end
