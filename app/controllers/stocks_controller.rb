class StocksController < ApplicationController
  def index
    @stocks = Stock.includes(:product) # eager loading
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to stocks_path, notice: "Movimiento registrado"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:product_id, :action, :quantity, :cost)
  end
end
