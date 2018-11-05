class Category < ApplicationRecord
  validates :name, length: { in: 2..100 }
end
