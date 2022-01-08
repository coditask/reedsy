FactoryBot.define do
  factory :item do
    code { "MyString" }
    name { "MyString" }
    price { 1 }
    store { FactoryBot.create :store }
  end
end
