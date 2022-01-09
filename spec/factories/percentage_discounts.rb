FactoryBot.define do
  factory :percentage_discount do
    minimum_items { 1 }
    discounted_items { 1 }
    percentage { 1 }
  end
end
