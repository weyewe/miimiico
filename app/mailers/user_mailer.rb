class UserMailer < ActionMailer::Base
  default :from => "eifion@asciicasts.com"
  
  def registration_confirmation(user)  
    @user = user 
    mail(:to => user.email, :subject => "Registered")  
  end
  
  def project_invitation( invited_user, inviting_user,  text, project , password )
    @user = invited_user 
    @project = project 
    @inviting_user = inviting_user
    @password = password 
    @text = text
    
    mail(:to => invited_user.email, :subject => "Invitation")
  end

end
