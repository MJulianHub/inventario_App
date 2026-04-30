require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:category) { Category.create!(name: 'Test Category') }
  let!(:product) { Product.create!(name: 'Test Product', code: 'T001', price: 10, stock: 5, category: category) }

  describe 'validations' do
    it 'is valid with correct data' do
      stock = Stock.new(
        product: product,
        action: :addition,
        quantity: 10,
        cost: 5.00
      )
      expect(stock).to be_valid
    end

    it 'is invalid without quantity' do
      stock = Stock.new(product: product, action: :addition, quantity: nil, cost: 5)
      expect(stock).not_to be_valid
    end

    it 'is invalid with zero quantity' do
      stock = Stock.new(product: product, action: :addition, quantity: 0, cost: 5)
      expect(stock).not_to be_valid
    end

    it 'is invalid without a cost' do
      stock = Stock.new(product: product, action: :addition, quantity: 1, cost: nil)
      expect(stock).not_to be_valid
    end
  end

  describe 'enum actions' do
    it 'defines addition, removal, and devolution' do
      expect(Stock.actions.keys).to contain_exactly("addition", "removal", "devolution")
      expect(Stock.actions.values).to contain_exactly(0, 1, 2)
    end
  end

  describe 'after_create callback' do
    it 'increments product stock on addition' do
      Stock.create!(product: product, action: :addition, quantity: 3, cost: 5)
      expect(product.reload.stock).to eq(8)
    end

    it 'decrements product stock on removal' do
      Stock.create!(product: product, action: :removal, quantity: 2, cost: 5)
      expect(product.reload.stock).to eq(3)
    end

    it 'increments product stock on devolution' do
      Stock.create!(product: product, action: :devolution, quantity: 4, cost: 5)
      expect(product.reload.stock).to eq(9)
    end
  end

  describe 'removal validation' do
    it 'prevents removal of more stock than available' do
      stock = Stock.new(product: product, action: :removal, quantity: 100, cost: 5)
      expect(stock).not_to be_valid
      expect(stock.errors[:base]).to include("Excede la cantidad de stock")
    end
  end
end
