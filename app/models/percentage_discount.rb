class PercentageDiscount < ApplicationRecord
  validates_presence_of :minimum_items, :discounted_items, :percentage
end
