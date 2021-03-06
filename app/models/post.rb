class Post < ApplicationRecord
  validates :content, presence: true, length: { in: 1..140 }

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImagesUploader

  def favorite(user)
    favorites.create(user_id: user.id)
  end

  def unfavorite(user)
    favorites.find_by(user_id: user.id).destroy
  end

  def favorited?(user)
    favorited_users.include?(user)
  end
end
