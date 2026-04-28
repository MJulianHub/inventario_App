require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @product_with_stock = products(:one)
    @product_with_stock.update!(stock: 20)
    @invalid_attributes = { product_id: nil, quantity: -1, cost: -1 }
  end

  test "deberia obtener indice" do
    get stocks_url
    assert_response :success
  end

  test "deberia obtener formulario nuevo" do
    get new_stock_url
    assert_response :success
  end

  test "deberia crear movimiento de entrada" do
    assert_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product.id, action: "addition", quantity: 10, cost: 100 } }
    end

    assert_redirected_to stocks_url
  end

  test "deberia crear movimiento de devolucion" do
    assert_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product.id, action: "devolution", quantity: 5, cost: 50 } }
    end

    assert_redirected_to stocks_url
  end

  test "deberia crear movimiento de salida" do
    assert_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product_with_stock.id, action: "removal", quantity: 5, cost: 100 } }
    end

    assert_redirected_to stocks_url
  end

  test "no deberia crear con atributos invalidos" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: @invalid_attributes }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear sin producto" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: { action: "addition", quantity: 10, cost: 100 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear sin cantidad" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product.id, action: "addition", cost: 100 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear con cantidad cero" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product.id, action: "addition", quantity: 0, cost: 100 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear con costo negativo" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product.id, action: "addition", quantity: 10, cost: -5 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia permitir salida mayor al stock disponible" do
    assert_no_difference("Stock.count") do
      post stocks_url, params: { stock: { product_id: @product_with_stock.id, action: "removal", quantity: 100, cost: 100 } }
    end

    assert_response :unprocessable_entity
  end
end