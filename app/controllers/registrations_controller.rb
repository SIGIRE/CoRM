##
# Controller that manager User
#
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  
  def index
    if !isLogged
      redirect_to new_user_session_url, :notice => "Vous devez etre connecte pour acceder a cette partie de l'application"
      return false
    end
    
    a = Ability.new(current_user)
    if !current_user.has_role? :admin and !current_user.has_role? :super_user
      redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
      return false
    end
    if a.can? :read, User
      if current_user.has_role? :admin
        @users = User.order('enabled DESC, id DESC').all
      elsif current_user.has_role? :super_user
        @users = User.order('id DESC').joins('LEFT JOIN users_roles ON ( users_roles.user_id = users.id )').joins('LEFT JOIN roles ON ( users_roles.role_id = roles.id )').where("users.enabled = TRUE").reject{|e| e.has_role? :admin }
      end
    end
    
    @real_users_count = 0;
    @users.each {|e|
      if (!e.has_role? :admin and e.enabled)
        @real_users_count += 1
      end
    }
  end
  
  def new
    if User.count > 0
      if self.isLogged
        a = Ability.new(current_user)
        if a.can? :create, User
          @user = User.new
        else
          redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
          return false
        end
      else
        redirect_to new_user_session_url, :notice => "Vous devez etre connecte pour acceder a cette partie de l'application"
        return false
      end
    end
  end
  
  def create
    a = Ability.new(current_user)
    if a.can? :create, User
      from = params[:user][:enabled]
      params[:user][:enabled] = (params[:user][:enabled] == '1')
      roles = params[:user][:roles]
      params[:user].delete :roles
      @user = User.new(params[:user])
      if @user.save
        if !roles.nil? and !roles.blank?
          roles.each do |r|
            @user.add_role(r)
          end
        end
        redirect_to users_url, :notice => t('devise.confirmations.account_created').gsub('[user]', @user.full_name)
      else
        redirect_to new_user_url(@user), :notice => "Une erreur est survenu lors de l'enregistrement de #{@user.full_name}"
      end
    else
      redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
      return false
    end
  end
  
  ##
  # Render a page to edit the User
  #
  def edit
    if !isLogged
      redirect_to new_user_session_url, :notice => "Vous devez etre connecte pour acceder a cette partie de l'application"
      return false
    end
    a = Ability.new(current_user)
    if a.cannot? :update, User
      redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
      return false
    end
    @email_disabled = true
    if current_user.has_role? :admin or current_user.has_role? :super_user
      @user = User.find(params[:id])
      @email_disabled = false
    else
      @user = current_user
    end
  end
  
  ##
  # Process to update the User
  #
  def update
    if !isLogged
      redirect_to new_user_session_url, :notice => "Vous devez etre connecte pour acceder a cette partie de l'application"
      return false
    end
    if current_user.has_role? :super_user
      @user = User.find(params[:id])
    elsif params[:id] == current_user.id
      @user = User.find(current_user.id)
    end
    params[:user][:enabled] = (params[:user][:enabled] == '1')
    password_changed = !params[:user][:password].empty?
    #si le champs password est non vide, on considère 
    successfully_updated = if password_changed
            #on effectue un update qui demande d'avoir entre un mot de passe
            @user.update_with_password(params[:user])
        else
            #sinon on effectue un update sans mot de passe, ce qui signifie que le mot de passe n'a pas ete modifie
            @user.update_without_password(params[:user])
        end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      redirect_to (current_user.has_role?(:super_user) ? users_url : root_path)
    else
      render "edit"
    end
  end
  
  def destroy
    if !isLogged
      redirect_to new_user_session_url, :notice => "Vous devez etre connecte pour acceder a cette partie de l'application"
      return false
    end
    return false
  end
  
  def isLogged
    return !(current_user.nil? or current_user.email.nil? or current_user.email.blank?)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "password"
    end
  end
  
end
