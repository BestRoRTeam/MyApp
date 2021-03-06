class SearchProvider
  attr_reader :results

  def initialize(key)
    @results = Product.all
    filter_by_key(key)
  end

  def filter_by_key(key)
    @results = if key.blank?
                 @results
               else
                 @results.search(key)
               end
  end
end