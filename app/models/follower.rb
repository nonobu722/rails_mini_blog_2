class Follower < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follow, class_name: 'User'
end
