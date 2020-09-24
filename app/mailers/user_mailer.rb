class UserMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers

  def welcome_reset_password_instructions user
    mail to: user.email, subject: I18n.t("mailers.user_mailer.welcome")
  end
end
