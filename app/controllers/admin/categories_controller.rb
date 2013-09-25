class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :addchild]
  layout 'admin'

  # GET /categories
  # GET /categories.json
  def index
    @pucrs = Category.where("name = '#{QA::Application.config.main_category}'").first
    if @pucrs == nil
      @pucrs = Category.create!(name: "#{QA::Application.config.main_category}", description: "Pontifícia Universidade Católica do Rio Grande do Sul")
    end    
    redirect_to admin_category_path(@pucrs)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_category_path(@category.parent.nil? ? @category : @category.parent), notice: 'A categoria foi criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_category_path(@category), notice: 'A categoria foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @parent = @category.parent
    @category.destroy
    respond_to do |format|
      if @parent.nil?
        format.html { redirect_to admin_categories_path }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_category_path(@parent), notice: 'A categoria foi removida com sucesso.' }
        format.json { render action: 'show', location: @parent }        
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description, :parent_id, :id)
    end
end
