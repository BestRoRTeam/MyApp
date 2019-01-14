class TempProduct < ApplicationRecord
  validates :name, length: { in: 2..100 }
  validates :category, presence: true
  validates :quantity, presence: true, numericality: { other_than: 0 }
end
