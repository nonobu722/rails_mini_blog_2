class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notify(user)
    @user = user
    mail to: @user.email, subject: t('mail.notification_subject')
  end

  def favorite_ranking(user)
    @user = user
    now = Time.zone
    @posts = Post.find(Favorite.where(updated_at: now.yesterday.beginning_of_day...now.today.beginning_of_day)\
      .group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    mail to: @user.email, subject: t('mail.favorite_ranking_subject')
  end
end
