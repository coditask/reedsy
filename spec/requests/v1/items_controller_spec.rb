require 'rails_helper'

RSpec.describe V1::ItemsController, type: :request do
  let!(:store) { FactoryBot.create :store }
  let!(:item) { FactoryBot.create :item, store: store }
  let!(:item2) { FactoryBot.create :item, store: store }
  let!(:item3) { FactoryBot.create :item }
  describe "GET /index" do
    it 'should render 404 if store is not found' do
      get "/v1/store/#{Store.last.id.next}/items", as: :json
      expect(response.code).to eq '404'
    end
    it 'should return all the items of a store ' do
      get "/v1/store/#{store.id}/items", as: :json
      expect(response.code).to eq '200'
      expect(json_response.map{ |item| item['code'] }).to eq [item.code, item2.code]
    end
  end
end
