class Item < ApplicationRecord
	belongs_to :store
	belongs_to :free_discount, optional: true
	belongs_to :percentage_discount, optional: true
	validates :code, presence: true, uniqueness: { scope: :store_id }
end
