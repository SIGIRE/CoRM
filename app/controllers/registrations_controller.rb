##
# Controller that manager User
#
class RegistrationsController < Devise::RegistrationsController
  #before_filter :authenticate
  
  ##
  # Render a page to edit the User
  #
  def edit
      @user = current_user
  end
  
  ##
  # Process to update the User
  #
  def update
    @user = User.find(current_user.id)
    
    password_changed = !params[:user][:password].empty?
    
    #si le champs password est non vide, on considère 
    successfully_updated = if password_changed
      #on effectue un update qui demande d'avoir entré un mot de passe
      @user.update_with_password(params[:user])
    else
      #sinon on effectue un update sans mot de passe, ce qui signifie que le mot de passe n'a pas été modifié
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end


  #protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "password"  
    end  
  end
  
end
