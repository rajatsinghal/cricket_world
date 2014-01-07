class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def send_invitation(user)
    @user = user
    mail(
      :subject => "Cricket League Invitation",
      :to => @user.email,
      :from => "rajat@octathorpeweb.com"
    )    
  end
  
end