class UserMailer < ActionMailer::Base
  default from: "vacorescheduling@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def verify_email(user)
    @user = user
    mail :to => "vaverifyscheduler@gmail.com", :subject => "An Email Has Been Sent to The Admin for Verification"
  end

  def been_verified(user)
    @user = user
    mail :to => user.email, :subject => "Your Account Has Been Verified and Added to the Application"
  end
end
