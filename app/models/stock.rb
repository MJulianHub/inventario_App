class Stock < ApplicationRecord
  belongs_to :product
  enum :action, {
    addition: 0,
    removal: 1,
    devolution: 2
  }

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :action, presence: true
  # Cada movimiento pertenece a un producto
  # Definimos los tipos de mivimientos con enum agregar 0, remover 1, devolucion 2

  # Valida solo si la accion es removal
  validate :cannot_remove_more_than_available, if: :removal?
  after_create :update_product_stock

  private
  def update_product_stock
    case action
    when "addition", "devolution"
      product.increment!(:stock, quantity)
    when "removal"
      product.decrement!(:stock, quantity)
    end
  end

  def cannot_remove_more_than_available
    return unless product
    if product.stock < quantity
      errors.add(:base, "Excede la cantidad de stock")
    end
  end
end
