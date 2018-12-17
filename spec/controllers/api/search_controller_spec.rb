require 'rails_helper'

 RSpec.describe Api::SearchController do
   describe 'GET #index' do
     subject { get :index, params: { key: key } }
     let(:key) { 'marg piz' }

     let!(:product) { FactoryBot.create :product, name: 'pizza margherita' }

     it do
       expect(subject).to be_successful
       expect(JSON.parse(subject.body))
         .to eq([{ 'id' => product.id, 'name' => product.name }])
     end
   end
 end