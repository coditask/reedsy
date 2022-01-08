module V1
	class ItemsController < ApplicationController
		helper ItemHelper

		before_action :get_store
		before_action :get_item, only: :update
		def index
			@items = @store.items
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
			@total = @store.items.sum(:price) and return if add_price_params[:items].blank?

			codes = add_price_params[:items].split(',').map(&:strip)
			codes_group = Hash[codes.group_by(&:itself).map { |code, count| [code, count.size] }]
			items = @store.items.where code: codes
			@total = BigDecimal(items.inject(0) do |sum, item|
				sum + codes_group[item.code] * item.price
			end)
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
			params.permit(:items)
		end
	end
end
