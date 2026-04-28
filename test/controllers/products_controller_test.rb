require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @category = categories(:one)
    @invalid_attributes = { name: "", code: "", price: -1 }
  end

  test "deberia obtener indice" do
    get products_url
    assert_response :success
  end

  test "deberia mostrar producto" do
    get product_url(@product)
    assert_response :success
  end

  test "deberia obtener formulario nuevo" do
    get new_product_url
    assert_response :success
  end

  test "deberia obtener formulario editar" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "deberia crear producto" do
    assert_difference("Product.count") do
      post products_url, params: { product: { name: "Nuevo Producto", code: "NEW001", price: 100, stock: 10, category_id: @category.id, active: true } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "no deberia crear producto sin nombre" do
    assert_no_difference("Product.count") do
      post products_url, params: { product: { code: "NEW001", price: 100 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear producto sin codigo" do
    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "Producto", price: 100 } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear producto con codigo duplicado" do
    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "Otro", code: @product.code } }
    end

    assert_response :unprocessable_entity
  end

  test "no deberia crear producto con precio negativo" do
    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "Producto", code: "NEW001", price: -10 } }
    end

    assert_response :unprocessable_entity
  end

  test "deberia actualizar producto" do
    patch product_url(@product), params: { product: { name: "Actualizado" } }
    assert_redirected_to product_url(@product)

    @product.reload
    assert_equal "Actualizado", @product.name
  end

  test "deberia eliminar producto sin movimientos" do
    # Crear producto sin movimientos para este test
    product_to_delete = Product.create!(
      name: "Producto para eliminar",
      code: "DEL001",
      price: 10,
      stock: 0,
      category: @category,
      active: true
    )
    
    assert_difference("Product.count", -1) do
      delete product_url(product_to_delete)
    end

    assert_redirected_to products_url
  end
end