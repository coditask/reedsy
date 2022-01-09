class Item < ApplicationRecord
	belongs_to :store
	validates :code, presence: true, uniqueness: { scope: :store_id }
end
