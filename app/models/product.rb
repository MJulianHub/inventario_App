class Product < ApplicationRecord
  belongs_to :category
  has_many :stocks, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :active, inclusion: { in: [true, false] }

  # Cada producto pertenece a un acategoria
  # Un producto tiene muchos movimientos de stock
end
