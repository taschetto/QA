class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description, :category_id, :user_id)
    end
end
