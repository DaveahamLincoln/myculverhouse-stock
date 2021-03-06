class UserMailer < ActionMailer::Base
  default from: "pookydaemon@myculverhouse.cba.ua.edu"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user=user
    mail :to => user.email, :subject => "myculverhouse.cba.ua.edu Password Reset"
  end

end
