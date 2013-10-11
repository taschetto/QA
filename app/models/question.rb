class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validate :valid_user

  def valid_user
    errors.add(:user_id, 'Você deve estar logado!') if (user_id.nil?)
  end  
end
