require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'creates product after validating fields' do
      @category = Category.create({
        id: 1,
        name: "furniture"
      })
      @product = Product.create({
        name: "Cool Thing",
        price_cents: 3000,
        quantity: 3,
        category: @category
      })

      expect(@product.errors.full_messages).to match_array([])
    end
    it 'validates :name, presence: true' do
      @category = Category.create({
        id: 1,
        name: "furniture"
      })
      @product = Product.create({
        price_cents: 3000,
        quantity: 3,
        category: @category
      })
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'validates :price_cents, presence: true' do
      @category = Category.create({
        id: 1,
        name: "furniture"
      })
      @product = Product.create({
        name: "Cool Thing",
        quantity: 3,
        category: @category
      })

      expect(@product.errors.full_messages).to include("Price cents can't be blank")
    end
    it 'validates :quantity, presence: true' do
      @category = Category.create({
        id: 1,
        name: "furniture"
      })
      @product = Product.create({
        name: "Cool Thing",
        price_cents: 3000,
        category: @category
      })

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      @category = Category.create({
        id: 1,
        name: "furniture"
      })
      @product = Product.create({
        name: "Cool Thing",
        price_cents: 3000,
        quantity: 3
      })

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
