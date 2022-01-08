module V1
	class ItemsController < ApplicationController
		before_action :get_store
		def index
			@items = @store.items
		end

		private

		def get_store
			@store = Store.find_by id: params[:store_id]
			render json: { error: 'Store not found' }, status: 404 unless @store
		end
	end
end