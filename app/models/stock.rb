class Stock < ApplicationRecord
  belongs_to :product
  enum action: {
    addition: 0,
    removal: 1,
    devolution: 2
  }

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :action, presence: true
  # Cada movimiento pertenece a un producto
  # Definimos los tipos de mivimientos con enum agregar 0, remover 1, devolucion 2
end
