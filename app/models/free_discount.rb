class FreeDiscount < ApplicationRecord
  validates_presence_of :minimum_items, :free_items
end
