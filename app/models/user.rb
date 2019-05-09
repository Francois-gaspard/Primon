class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :registerable

  validate :uniqueness_of_user

  def self.email
    User.first&.email
  end

  def self.can_register?
    User.count == 0
  end

  def uniqueness_of_user
    if !User.can_register?
      errors.add(:base, "There is already a registered user. This is currently a single-user app.")\
    end
  end
end
