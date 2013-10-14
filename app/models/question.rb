class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validate :valid_user, on: :create
 
  def valid_user
    errors[:user_id] << "Você deve estar logado para realizar esta operação." if user_id.nil?
  end  
end
