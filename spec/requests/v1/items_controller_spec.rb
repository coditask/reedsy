require 'rails_helper'

RSpec.describe V1::ItemsController, type: :request do
  let!(:store) { FactoryBot.create :store }
  let!(:item) { FactoryBot.create :item, store: store }
  let!(:item2) { FactoryBot.create :item, store: store }
  let!(:item3) { FactoryBot.create :item }
  describe "GET /index" do
    it 'should render 404 if store is not found' do
      get "/v1/store/#{Store.last.id.next}/items", as: :json
      expect(response).to have_http_status(:not_found)
    end
    it 'should return all the items of a store ' do
      get "/v1/store/#{store.id}/items", as: :json
      expect(response).to have_http_status(:ok)
      expect(json_response.map{ |item| item['code'] }).to eq [item.code, item2.code]
    end
  end

  describe "PATCH /update" do
    it 'should render 404 if item is not found' do
      patch "/v1/store/#{Store.last.id}/items/#{Item.last.id.next}", as: :json
      expect(response).to have_http_status(:not_found)
    end
    it 'should render unprocessable_entity if new price is not passed' do
      patch "/v1/store/#{Store.last.id}/items/#{item.id}", as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should update the item price if new price is passed' do
      patch "/v1/store/#{Store.last.id}/items/#{item.id}", as: :json, params: { price: 200 }
      expect(response.code).to eq '204'
      expect(item.reload.price).to eq 200
    end
  end

  describe "GET /add_price" do
    before do
      item.update_column :price, 100
      item2.update_column :price, 200
      item3.update_column :price, 200
    end

    context 'All unique codes' do
      it 'should add the price of all the codes only once' do
        get "/v1/store/#{store.id}/items/add_price?items=#{item.code}", as: :json
        expect(response).to have_http_status(:ok)
        expect(json_response['total']).to eq '1.00€'
      end
    end

    context 'Repeated codes' do
      it 'should add the price multiple times all the repeated codes' do
        get "/v1/store/#{store.id}/items/add_price?items=#{item.code}, #{item.code}, #{item2.code}", as: :json
        expect(response).to have_http_status(:ok)
        expect(json_response['total']).to eq '4.00€'
      end
    end

    context 'No codes have been passed' do
      it 'should add the price of all the items' do
        get "/v1/store/#{store.id}/items/add_price", as: :json
        expect(response).to have_http_status(:ok)
        expect(json_response['total']).to eq '3.00€'
      end
    end
  end
end