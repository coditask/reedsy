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
			@total = 0 and return if add_price_params[:items].blank?

			codes = add_price_params[:items].split(',').map(&:strip)
			codes_group = Hash[codes.group_by(&:itself).map { |code, count| [code, count.size] }]
			items = @store.items.where code: codes
			@total = items.inject(0) do |sum, item|
				sum + BigDecimal(effective_item_price(item, codes_group))
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
			params.permit(:items)
		end

		def effective_item_price(item, codes_group)
			if item.percentage_discount_id? && codes_group[item.code] >= item.percentage_discount.minimum_items.to_i
				if item.percentage_discount.discounted_items.nil?
					non_discounted_items = 0
				else
					non_discounted_items = codes_group[item.code] - item.percentage_discount.discounted_items
				end
				(non_discounted_items + (codes_group[item.code] - non_discounted_items) * BigDecimal(((100 - item.percentage_discount.percentage)/100.0).to_s)) * item.price
			elsif item.free_discount_id? && codes_group[item.code] >= item.free_discount.minimum_items
				free_items = item.free_discount.free_items
				(codes_group[item.code] - free_items) * item.price
			else
				codes_group[item.code] * item.price
			end
		end
	end
end
