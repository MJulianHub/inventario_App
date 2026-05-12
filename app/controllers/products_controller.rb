class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.includes(:category).order(created_at: :desc)  # eager loading
  end

  def show
    @product = Product.includes(:stocks).find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to new_stock_path(product_id: @product.id), notice: "Producto creado con exito, agregue el stock inicial"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Producto eliminado con exito"
    else
      redirect_to products_path, alert: "No se puede eliminar el producto, tiene movimientos asociados"
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:code, :name, :description, :price, :stock, :category_id, :active)
  end
end
