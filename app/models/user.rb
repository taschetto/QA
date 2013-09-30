class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validate :birthday_is_valid_datetime

  def birthday_is_valid_datetime
    errors.add(:birthday, ' deve ser inferior à data corrente.') if (birthday.present? && birthday >= Date.today)
  end
end
