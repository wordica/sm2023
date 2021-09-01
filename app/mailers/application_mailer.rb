class ApplicationMailer < ActionMailer::Base
  default :from => "info@photoclicker.net"
  default :to => "info@photoclicker.net"



  def message_notification(message_sender,message_to)
    @message_sender = message_sender
    @message_to = message_to
    mail(:from => 'info@photoclicker.net', :to => @message_to.email, :subject => 'You have new message on PhotoClicker.net', :template_path => 'application_mailer', :template_name => "message_notification", :name => @message_sender)
  end


  def admin_mailing_start(user_mailing)

    #@user_mailing = user_mailing.user
    #@user_email = user_mailing.email
    @user_token = AdvMailing.where('email LIKE ?',"%#{user_mailing.email}%").first.token
    mail(:to => user_mailing.email, :from => user_mailing.sender_email, :subject => user_mailing.subject, :template_path => 'application_mailer', :template_name => "adv_mailing", :token => @user_token )
  
  end


end
