# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def notify
    user = User.new(name: 'testuser', email: 'hoge@example.com', password: 'password01')
    NotificationMailer.notify(user)
  end

  def favorite_ranking
    user = User.new(name: 'testuser', email: 'hoge@example.com', password: 'password01')
    NotificationMailer.favorite_ranking(user)
  end
end
