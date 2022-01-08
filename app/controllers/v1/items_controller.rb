module V1
	class ItemsController < ApplicationController
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
	end
end