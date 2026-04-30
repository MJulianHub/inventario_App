require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:category) { Category.create!(name: 'Test Category') }

  describe 'validations' do
    it 'is valid with required fields' do
      product = Product.new(
        name: 'Test Product',
        code: 'T001',
        price: 10.00,
        stock: 0,
        category: category
      )
      expect(product).to be_valid
    end

    it 'is invalid without a name' do
      product = Product.new(name: nil, code: 'T002', price: 5, stock: 0, category: category)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is invalid without a code' do
      product = Product.new(name: 'Test', code: nil, price: 5, stock: 0, category: category)
      expect(product).not_to be_valid
    end

    it 'is invalid with a duplicate code' do
      Product.create!(name: 'Product A', code: 'D001', price: 5, stock: 0, category: category)
      duplicate = Product.new(name: 'Product B', code: 'D001', price: 10, stock: 0, category: category)
      expect(duplicate).not_to be_valid
    end

    it 'is invalid with a negative price' do
      product = Product.new(name: 'Test', code: 'T003', price: -1, stock: 0, category: category)
      expect(product).not_to be_valid
    end

    it 'is valid with zero price' do
      product = Product.new(name: 'Free Item', code: 'F001', price: 0, stock: 0, category: category)
      expect(product).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to category' do
      expect(described_class.reflect_on_association(:category)).not_to be_nil
    end

    it 'has many stocks' do
      expect(described_class.reflect_on_association(:stocks)).not_to be_nil
    end
  end

  describe 'defaults' do
    it 'is active by default' do
      product = Product.create!(name: 'New', code: 'N001', price: 1, stock: 0, category: category)
      expect(product.active).to be true
    end
  end
end
