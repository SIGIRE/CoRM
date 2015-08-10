# encoding: utf-8
class WebmailConnectionsController < ApplicationController

  def update
	if current_user.has_role?(:admin)
		connection = WebmailConnection.find(params[:webmail_connection][:id])
		if connection.update_attributes(params[:webmail_connection].except(:id))
			check()
		end
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

	def check
		if current_user.has_role?(:admin)
			connection = WebmailConnection.first
			if (!WebmailConnection.check(connection))
				flash[:alert] = "Les paramètres de connexion saisis sont invalides."
				connection.active = false
				connection.save
			else
				flash[:notice] = "Les paramètres de connexion sont corrects et ont été sauvegardés."
		end
		redirect_to(:controller => "settings",  :action => 'index')
	else
		redirect_to root_url
		return false
	end
	end
end
