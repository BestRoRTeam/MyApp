# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, length: { in: 2..100 }
  validates :shop, length: { in: 2..100 }
  validates :category, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { other_than: 0 }
end
