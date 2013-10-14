class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_category
  before_action :set_question
  before_action :set_user

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = @question.id
    @answer.user_id = @user.id unless @user.nil?
    respond_to do |format|
      if @answer.save
        format.html { redirect_to category_question_path(@question.category_id, @question.id), notice: 'Resposta criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @user.user_level == 0 && @answer.user_id != @user.id
      @answer.errors[:user_id] << "Você não pode editar respostas de outros usuários."
    end
    respond_to do |format|
      if @answer.errors.empty?
        if @answer.update(answer_params)
          format.html { redirect_to category_question_path(params[:category_id], @answer.question_id), notice: 'Pergunta atualizada com sucesso.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    if @user.user_level == 0 && @answer.user_id != @user.id
      @answer.errors[:user_id] << "Você não pode apagar respostas de outros usuários."
    end    
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to category_question_path(params[:category_id], params[:question_id]) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_user
      @user = user_signed_in? ? User.find(current_user.id) : nil
    end            

    def set_category
      @category = Category.find(params[:category_id])
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:description, :question_id, :user_id)
    end
end
