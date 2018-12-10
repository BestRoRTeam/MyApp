class Product < ApplicationRecord
  validates :name, length: { in: 2..100 }
  validates :shop, length: { in: 2..100 }
  validates :category, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { other_than: 0 }

  def values
    vals = []
    attributes.values[1..-3].each do |x|
      vals.push((x.is_a?(Float) ? format('%.2f', x) : x))
    end
    vals
  end

  def read_comment
    comment = Comment.where(product_id: id)
    if comment[0]
      comment[0].content
    else
      ''
    end
  end

  def self.create_delay_job(params, u_id, period, date)
    Product.create(name: params[:name],
                   shop: params[:shop],
                   category: params[:category],
                   price: params[:price].to_f,
                   quantity: params[:quantity].to_i,
                   user_id: u_id)

    new_date = ProductProvider.calculate_date(date, period)
    delay(run_at: new_date).create_delay_job(params, u_id, period, new_date)
  end

  def self.delete_delay_job(job_id, u_id)
    job = Delayed::Job.find(job_id)
    job.delete if job.payload_object.args[1] == u_id
  end
  
  def self.categories_names
    names = []
    all.column_names[1..-3].each do |name|
      names.push(name.capitalize.tr('_', ' '))
    end
    names
  end

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
