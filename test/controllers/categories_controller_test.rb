require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_with_products = categories(:one)
    @category_without_products = categories(:two)  # Esta no tiene productos
    @invalid_attributes = { name: "", description: "" }
  end

  test "deberia obtener indice" do
    get categories_url
    assert_response :success
  end

  test "deberia mostrar categoria" do
    get category_url(@category_with_products)
    assert_response :success
  end

  test "deberia obtener formulario nuevo" do
    get new_category_url
    assert_response :success
  end

  test "deberia obtener formulario editar" do
    get edit_category_url(@category_with_products)
    assert_response :success
  end

  test "deberia crear categoria" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Nueva Categoria", description: "Test descripcion" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "no deberia crear categoria con atributos invalidos" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: @invalid_attributes }
    end

    assert_response :unprocessable_entity
  end

  test "deberia actualizar categoria" do
    patch category_url(@category_with_products), params: { category: { name: "Actualizado" } }
    assert_redirected_to category_url(@category_with_products)

    @category_with_products.reload
    assert_equal "Actualizado", @category_with_products.name
  end

  test "no deberia actualizar categoria con nombre duplicado" do
    other_category = categories(:two)
    patch category_url(@category_with_products), params: { category: { name: other_category.name } }
    assert_response :unprocessable_entity
  end

  test "deberia eliminar categoria sin productos" do
    # Crear categoria sin productos para este test
    category_to_delete = Category.create!(name: "Categoria para eliminar", description: "Test")

    assert_difference("Category.count", -1) do
      delete category_url(category_to_delete)
    end

    assert_redirected_to categories_url
  end
end
