class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notify(user)
    @user = user
    mail to: @user.email, subject: t('mail.notification_subject')
  end
end
