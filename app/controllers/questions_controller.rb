class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_question2, only: [:fix]
  before_action :set_category
  before_action :set_user

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.category_id = @category.id
    @question.user_id = @user.id unless @user.nil?

    respond_to do |format|
      if @question.save
        format.html { redirect_to category_question_path(@question.category_id, @question), notice: 'Pergunta criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def fix
    if @user.user_level == 0
      @question.errors[:user_id] << "Você não pode fixar/desafixar perguntas."
    end
    respond_to do |format|
      if @question.errors.empty?
        @question.fixed = !@question.fixed
        if @question.update(params.permit(:fixed))
          format.html { redirect_to category_path(@question.category_id), notice: 'Pergunta fixada com sucesso.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end    

  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @user.user_level == 0 && @question.user_id != @user.id
      @question.errors[:user_id] << "Você não pode editar perguntas de outros usuários."
    end
    respond_to do |format|
      if @question.errors.empty?
        if @question.update(question_params)
          format.html { redirect_to category_question_path(@question.category_id, @question), notice: 'Pergunta atualizada com sucesso.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    if @user.user_level == 0 && @question.user_id != @user.id
      @question.errors[:user_id] << "Você não pode apagar perguntas de outros usuários."
    end    
    @question.destroy
    respond_to do |format|
      format.html { redirect_to category_path(params[:category_id])}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_question2
      @question = Question.find(params[:question_id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_user
      @user = user_signed_in? ? User.find(current_user.id) : nil
    end        

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :description, :category_id, :user_id, :fixed)
    end
end
