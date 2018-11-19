require 'rails_helper.rb'

RSpec.describe ProductProvider do
  let(:product_provider) { ProductProvider }

  describe '.dates' do
    it do
      expect(product_provider.dates).to eq(%w[Week Month Year All])
    end
  end

  describe '.date_selector' do
    it do
      expect(product_provider.date_selector('Week').strftime('%m/%d/%Y')).to eq(1.week.ago.strftime('%m/%d/%Y'))
      expect(product_provider.date_selector('Month').strftime('%m/%d/%Y')).to eq(1.month.ago.strftime('%m/%d/%Y'))
      expect(product_provider.date_selector('Year').strftime('%m/%d/%Y')).to eq(12.months.ago.strftime('%m/%d/%Y'))
    end
  end
end
