class PasswordsController < ApplicationController

  def edit
    @filter ="credential"
    @user = current_user
    @profile = current_user.profile
  end
  
  def edit_credential
    @user = current_user 
    @profile = current_user.profile 
  end

  def update
    @user = current_user

    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to edit_credential_url  , :notice => "Password updated!"
    else
      redirect_to edit_credential_url, :notice => "Fail. Try again"
    end
  end
  
  def edit_username
    @user = current_user
    @profile = current_user.profile
  end
end