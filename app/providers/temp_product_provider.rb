class TempProductProvider
  class << self
    def get_json(user_id)
      products = TempProduct.where(user_id: user_id)
      products.to_json
    end
  end
end
