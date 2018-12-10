class Plan < ApplicationRecord
  validates :title, length: { in: 2..100 }
  validates :since_date, presence: true
  validates :to_date, presence: true
  validates :goal, presence: true, numericality: { other_than: 0 }

  def status
    return @result if @result

    products = Product.where(user_id: user_id).order('created_at')
    products = products.where('created_at > ?', since_date).where('created_at < ?', to_date)

    @result = 0
    products.each do |product|
      @result += product.price * product.quantity
    end

    @result
  end

  def color
    status > goal ? 'red' : 'green'
  end
end
