require 'rails_helper'

RSpec.describe V1::ItemsController, type: :request do
  let!(:store) { FactoryBot.create :store }
  let!(:item) { FactoryBot.create :item, store:  }
  let!(:item2) { FactoryBot.create :item, store: }
  let!(:item3) { FactoryBot.create :item }
  describe 'GET /index' do
    it 'should render 404 if store is not found' do
      get "/v1/store/#{Store.last.id.next}/items", as: :json
      expect(response).to have_http_status(:not_found)
    end
    it 'should return all the items of a store ' do
      get "/v1/store/#{store.id}/items", as: :json
      expect(response).to have_http_status(:ok)
      expect(json_response.map { |item| item['code'] }).to eq [item.code, item2.code]
    end
  end

  describe 'PATCH /update' do
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

  # Code         | Name                   |  Price
  # -------------------------------------------------
  # MUG          | Reedsy Mug             |   6.00€
  # TSHIRT       | Reedsy T-shirt         |  15.00€
  # HOODIE       | Reedsy Hoodie          |  20.00€
  describe 'GET /add_price' do
    before do
      item.update_columns price: 600, code: 'MUG', store_id: store.id
      item2.update_columns price: 1500, code: 'TSHIRT', store_id: store.id
      item3.update_columns price: 2000, code: 'HOODIE', store_id: store.id
    end

    context 'No offer' do
      context 'Items: MUG, TSHIRT, HOODIE' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, HOODIE", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '41.00€'
        end
      end

      context 'Items: MUG, TSHIRT, MUG' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, MUG", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '27.00€'
        end
      end

      context 'Items: MUG, TSHIRT, MUG, MUG' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, MUG, MUG", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '33.00€'
        end
      end

      context 'Items: MUG, TSHIRT, TSHIRT, TSHIRT, TSHIRT, MUG, HOODIE' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, TSHIRT, TSHIRT, TSHIRT, MUG, HOODIE",
              as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '92.00€'
        end
      end

      context 'No codes have been passed' do
        it 'should return 0' do
          get "/v1/store/#{store.id}/items/add_price", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '0.00€'
        end
      end
    end

    context 'Offer' do
      let(:free_discount) { FactoryBot.create :free_discount, minimum_items: 2 }
      let(:percentage_discount) do
        FactoryBot.create :percentage_discount, minimum_items: 3, discounted_items: nil, percentage: 30
      end
      before do
        item.update_column :free_discount_id, free_discount.id
        item2.update_column :percentage_discount_id, percentage_discount.id
      end
      context 'Items: MUG, TSHIRT, HOODIE' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, HOODIE", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '41.00€'
        end
      end

      context 'Items: MUG, TSHIRT, MUG' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, MUG", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '21.00€'
        end
      end

      context 'Items: MUG, TSHIRT, MUG, MUG' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, MUG, MUG", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '27.00€'
        end
      end

      context 'Items: MUG, TSHIRT, MUG, MUG, MUG' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, MUG, MUG, MUG", as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '33.00€'
        end
      end

      context 'Items: MUG, TSHIRT, TSHIRT, TSHIRT, TSHIRT, MUG, HOODIE' do
        it 'should return the correct total' do
          get "/v1/store/#{store.id}/items/add_price?item_codes=MUG, TSHIRT, TSHIRT, TSHIRT, TSHIRT, MUG, HOODIE",
              as: :json
          expect(response).to have_http_status(:ok)
          expect(json_response['total']).to eq '68.00€'
        end
      end
    end
  end
end
