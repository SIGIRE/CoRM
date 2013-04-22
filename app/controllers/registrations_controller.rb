#!/bin/env ruby
# encoding: utf-8

##
# Controller that manager User
#
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  
  ##
  # Render the list of all users
  #   The super-user only see normal-users and super-users (not admin-users)
  #
  def index
    if !isLogged
      flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application".html_safe
      redirect_to new_user_session_url
      return false
    end
    # get Ability for this user
    a = Ability.new(current_user)
    # if current_user have ability to read some users
    if a.can? :read, User
      if current_user.has_role? :admin
        @users = User.order('enabled DESC, id DESC').all
      elsif current_user.has_role? :super_user
        @users = User.order('id DESC').joins('LEFT JOIN users_roles ON ( users_roles.user_id = users.id )').joins('LEFT JOIN roles ON ( users_roles.role_id = roles.id )').where("users.enabled = TRUE").reject{|e| e.has_role? :admin }
      else
        @users = User.all_reals
      end
      @all_reals_user_count = User.all_reals.count
    else
      flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.show')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
      redirect_to root_url
      return false
    end
  end
  
  def new
    if User.count > 0
      if self.isLogged
        a = Ability.new(current_user)
        if a.can? :create, User
          @user = User.new if @user.nil?
        else
          flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
          redirect_to root_url
          return false
        end
      else
        flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application".html_safe
        redirect_to new_user_session_url
        return false
      end
    else
      @user = User.new(:forename => 'Admin', :surname => 'SIGIRE', :email => 'admin@sigire.fr')
      @user.add_role(:admin)
      @user.add_role(:super_user)
      @first_creation = true
    end
  end
  
  def show
    if self.isLogged
      a = Ability.new(current_user)
      if a.can? :read, User or current_user.id == params[:id]
        @user = User.find(params[:id])
      else
        flash[:error] = "Vous n'avez pas les droits pour visualiser cette page."
        redirect_to root_url
      end
    else
      flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application".html_safe
      redirect_to new_user_session_url
    end
  end
  
  def create
    if User.count > 0
        a = Ability.new(current_user)
        if a.can? :create, User
          # Enabled and SuperUser role
          params[:user][:enabled] = (params[:user][:enabled] == '1')
          superUserRole = (params[:user][:super] == "1")
          params[:user].delete :super
          @user = User.new(params[:user])
          # Save and add Roles
          if @user.save
            if (!@user.has_role?(:super_user) and superUserRole)
              @user.add_role(:super_user)
            elsif (@user.has_role?(:super_user) and !superUserRole)
              @user.remove_role(:super_user)
            end 
            redirect_to users_url, :notice => t('devise.confirmations.account_created').gsub('[user]', @user.full_name)
          else
            redirect_to new_user_url(@user), :notice => "Une erreur est survenu lors de l'enregistrement de #{@user.full_name}"
          end
        else
          redirect_to root_url, :notice => t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.new')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
          return false
        end
    else
      @user = User.new(params[:user])
      @user.save
      if !@user.has_role? :admin
        @user.add_role :admin
      end
      redirect_to new_user_session_url, :notice => 'Vous vous etes correctement enregistre. Veuillez vous connecter.'
    end
  end
  
  ##
  # Render a page to edit the User
  #
  def edit
    # if he's not logged in, redirect him
    if !isLogged
      flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application"
      redirect_to new_user_session_url
      return false
    end
    # get his ability
    a = Ability.new(current_user)
    # disabled the email field, by default
    @email_disabled = true
    # If the user can't update Users, he may still change his own account
    if a.cannot? :update, User
      if current_user.id.to_s == params[:id] # this is his account
        @user = current_user
      else # this is not his account
        flash[:error] = t('app.cancan.messages.unauthorized').gsub('[action]', t('app.actions.edit')).gsub('[undefined_article]', t('app.default.undefine_article_male')).gsub('[model]', t('app.controllers.User'))
        redirect_to root_url
        return false
      end
    elsif current_user.has_role?(:super_user) or current_user.has_role?(:admin) # this is an admin, yeah !
      @user = User.find(params[:id])
      @email_disabled = false
    end
  end
  
  ##
  # Process to update the User
  #
  def update
    if !isLogged
      flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application"
      redirect_to new_user_session_url
      return false
    end
    if current_user.has_role?(:super_user) or current_user.has_role?(:admin)
      @user = User.find(params[:id])
    elsif params[:id] == current_user.id
      @user = User.find(current_user.id)
    end
    if params[:user][:enabled]
      params[:user][:enabled] = (params[:user][:enabled] == '1')
    end
    
    
    # tmp role treatment
    superUserRole = (params[:user][:super] == '1')
    params[:user].delete :super
    
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
      if (!@user.has_role?(:super_user) and superUserRole)
        @user.add_role(:super_user)
      elsif (@user.has_role?(:super_user) and !superUserRole)
        @user.remove_role(:super_user)
      end
      redirect_to ((current_user.has_role?(:super_user) or current_user.has_role?(:admin)) ? users_path : root_path)
    else
      render "edit"
    end
  end
  
  def destroy
    if !isLogged
      flash[:error] = "Vous devez etre connecté pour accéder à cette partie de l'application"
      redirect_to new_user_session_url
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
  
  def session_new
    @user = User.find_by_email(params[:user][:email])
    if @user and @user.valid_password?(params[:user][:password])
      if @user.enabled == true
        sign_in(:user, @user)
        current_user.remember_me!

          #ensure remember_user_token is set
          if Rails.env.production?
            cookies.signed["remember_user_token"] = {
              :value => @user.class.serialize_into_cookie(user.reload),
              :expires => 3.months.from_now,
              :domain => ".app_name.com",
            }
          end
        redirect_to root_url, :notice => t('devise.sessions.signed_in')
      else
        redirect_to new_user_session_url, :notice => t('devise.failure.locked')
      end
    else
      flash[:error] = t('devise.failure.incorrect')
      redirect_to new_user_session_url
    end
  end
  
end
