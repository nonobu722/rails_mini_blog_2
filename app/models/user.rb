class User < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: { in: 1..20 },
                   format: { with: /\A[a-zA-Z]+\z/ }
  validates :profile, length: { maximum: 200 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy
  # rubocop:disable all
  has_many :active_followers, class_name: 'Follower', foreign_key: 'follow_id', dependent: :destroy
  has_many :passive_followers, class_name: 'Follower', foreign_key: 'followed_id', dependent: :destroy
  # rubocop:enable all
  has_many :followed, through: :active_followers
  has_many :follow, through: :passive_followers
  has_many :favorites, dependent: :destroy

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def follow(other_user)
    active_followers.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_followers.find_by(followed_id: other_user.id).destroy
  end

  def followed?(other_user)
    followed.include?(other_user)
  end
end
