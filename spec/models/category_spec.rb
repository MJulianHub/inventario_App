require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      category = Category.new(name: 'Electronics')
      expect(category).to be_valid
    end

    it 'is invalid without a name' do
      category = Category.new(name: nil)
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("no puede estar en blanco")
    end

    it 'is invalid with a duplicate name' do
      Category.create!(name: 'Electronics')
      duplicate = Category.new(name: 'Electronics')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to include("ya está en uso")
    end
  end

  describe 'associations' do
    it 'has many products' do
      association = described_class.reflect_on_association(:products)
      expect(association).not_to be_nil
      expect(association.options[:dependent]).to eq(:restrict_with_error)
    end
  end

  describe 'destroy restriction' do
    it 'prevents deletion when products exist' do
      category = Category.create!(name: 'Books')
      category.products.create!(name: 'Book 1', code: 'B001', price: 10, stock: 0)
      expect(category.destroy).to be false
      expect(Category.exists?(category.id)).to be true
    end
  end
end
