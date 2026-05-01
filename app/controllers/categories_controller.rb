class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]

  def index
    @categories = Category.order(created_at: :desc)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: "Categoria creada con exito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Categoria actualizada con exito."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: "Categoria eliminada con exito"
    else
      redirect_to categories_path, alert: "No se puede eliminar la categoria, tiene productos asociados"
    end
    
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
