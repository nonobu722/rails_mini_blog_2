class User < ApplicationRecord
  before_save { self.email = email.downcase }

  VALID_NAME_REGEX = /\A[a-zA-Z]+\z/.freeze
  VALID_EMAIL_REGEX = /\A[\x21-\x3f\x41-\x7e]+@(?:[-a-z0-9]+\.)+[a-z]{2,}\z/i.freeze

  validates :name, uniqueness: true, presence: true, length: { in: 1..20 },
                   format: { with: VALID_NAME_REGEX }
  validates :profile, length: { maximum: 200 }
  validates :email, uniqueness: true, presence: true, format: { with: VALID_EMAIL_REGEX }

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
  has_many :comments, dependent: :destroy

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
