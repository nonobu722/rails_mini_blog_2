class NotificationMailer < ApplicationMailer
  def notify(user)
    @user = user
    mail to: @user.email, subject: t('mail.notification_subject')
  end
end
