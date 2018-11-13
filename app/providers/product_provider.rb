class ProductProvider
  class << self
    def dates
      %w[Week Month Year All]
    end

    def date_selector(choice)
      if choice == 'Week'
        1.week.ago
      elsif choice == 'Month'
        1.month.ago
      elsif choice == 'Year'
        12.months.ago
      end
    end
  end
end
