namespace :send_mail do
  desc 'メール送信'

  # 「いいね」数ランキング１０位までの投稿をメールで通知する
  task favorite_ranking_mail: :environment do
    users = User.all

    users.each do |user|
      NotificationMailer.favorite_ranking(user).deliver
    end
  end
end
