FactoryBot.define do
  factory :free_discount do
    minimum_items { 1 }
    free_items { 1 }
  end
end
