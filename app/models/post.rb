class Post < ApplicationRecord
  validates :content, presence: true, length: { in: 1..140 }
  belongs_to :user
end
