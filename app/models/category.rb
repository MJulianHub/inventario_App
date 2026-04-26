class Category < ApplicationRecord
  # Una categoria tiene muchos productos y al ser eliminada una categoria se eliminaran los productos
  has_many :products, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
end
