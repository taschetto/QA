class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validate :valid_question, on: :create
 
  def valid_question
    errors[:user_id] << "Você deve estar logado para realizar esta operação." if user_id.nil?
    errors[:title] << "inválido." if title.empty?
    errors[:description] << "inválida." if description.empty?
  end  
end
