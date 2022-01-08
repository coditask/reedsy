FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "MyString#{n}" }
    name { "MyString" }
    price { 1 }
    store { FactoryBot.create :store }
  end
end
