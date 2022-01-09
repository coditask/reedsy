module V1
	class ItemsController < ApplicationController
		helper ItemHelper

		before_action :get_store
		before_action :get_item, only: :update

		def index
			@items = Rails.cache.fetch(Item.maximum(:updated_at)) do
				@store.items
			end
		end

		def update
			head :unprocessable_entity and return if update_params[:price].blank?

			@item.price = update_params[:price]
			if @item.save
				head :no_content
			else
				head :unprocessable_entity
			end
		end

		def add_price
			@item_codes = add_price_params[:item_codes]
			@total = Rails.cache.fetch([@item_codes, Item.maximum(:updated_at), PercentageDiscount.maximum(:updated_at), FreeDiscount.maximum(:updated_at)]) do
				StoreService.total_price_of_items(@store, @item_codes)
			end
		end

		private

		def get_store
			@store = Store.find_by id: params[:store_id]
			render json: { error: 'Store not found' }, status: 404 unless @store
		end

		def get_item
			@item = Item.find_by id: params[:id]
			render json: { error: 'Item not found' }, status: 404 unless @item
		end

		def update_params
			params.permit(:price)
		end

		def add_price_params
			params.permit(:item_codes)
		end
	end
end
