ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "asciicasts.com",  
  :user_name            => "willy.rails.learn",  
  :password             => "rails1234R",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}