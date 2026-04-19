class Category < ApplicationRecord
  # Una categoria tiene muchos productos y al ser eliminada una categoria se eliminaran los productos
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
