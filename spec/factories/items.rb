FactoryBot.define do
  factory :item do
    sequence(:code) { |n| "MyString#{n}" }
    name { 'MyString' }
    price { 1 }
    store { FactoryBot.create :store }

    trait(:free_discount) do
      free_discount { FactoryBot.create :free_discount }
    end

    trait(:percentage_discount) do
      percentage_discount { FactoryBot.create :percentage_discount }
    end
  end
end
