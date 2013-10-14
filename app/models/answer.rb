class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validate :valid_answer
 
  def valid_answer
    errors[:user_id] << "Você deve estar logado para realizar esta operação." if user_id.nil?
    errors[:description] << "inválida." if description.empty?
  end    
end
