class User < ApplicationRecord

  validates :name, uniqueness: true, presence: true, length: { in: 1..20 },
            format: { with: /\A[a-zA-Z]+\z/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

  def email_required?
    false
  end
  
  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
