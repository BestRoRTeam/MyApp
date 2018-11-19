# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, length: { in: 2..100 }
  validates :shop, length: { in: 2..100 }
  validates :category, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { other_than: 0 }

  def self.total_price
    total = 0
    all.each { |product| total += product.price * product.quantity }
    total
  end
  
  def self.total_price_by_category
    total = {}
    all.each do |product|
      total[product.category] = 0
      total[product.category] += product.price * product.quantity
    end
    total
  end
end
