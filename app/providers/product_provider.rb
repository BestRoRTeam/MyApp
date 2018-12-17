class ProductProvider
  
  class << self
    def dates
      %w[Week Month Year All]
    end

    def calculate_date(date, period)
      curr_date = Date.parse date

      if period == 'Day'
        (curr_date + 1.day).to_s
      elsif period == 'Week'
        (curr_date + 1.week).to_s
      elsif period == 'Month'
        (curr_date + 1.month).to_s
      elsif period == 'Year'
        (curr_date + 1.year).to_s
      end
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
