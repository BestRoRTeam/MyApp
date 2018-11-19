require 'rails_helper.rb'

RSpec.describe Product do
  let!(:product1) { FactoryBot.create :product }
  let(:product2) { FactoryBot.create :product }

  describe '.total_price' do
    it do
      before = Product.where(user_id: -1).total_price
      diff = product2.price * product2.quantity
      expect(Product.where(user_id: -1).total_price).to eq(before + diff)
    end
  end

  describe '.total_price_by_category' do
    it do
      before = Product.where(user_id: -1).total_price_by_category
      diff = { product2.category => product2.price * product2.quantity }
      expect(Product.where(user_id: -1).total_price_by_category).to eq(before.merge(diff))
    end
  end

  describe '.categories_names' do
    it do
      expect(Product.where(user_id: -1).categories_names.size).to eq(Product.where(user_id: -1).column_names[1..-3].size)
    end
  end

  describe '#values' do
    it do
      expect(product1.values.size).to eq(product1.attributes.values.to_a.size - 3)
    end
  end
end
