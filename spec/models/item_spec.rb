require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:free_discount_item) { FactoryBot.create :item, :free_discount }
  let(:percentage_discount_item) { FactoryBot.create :item, :percentage_discount }

  it 'should validate the uniqueness of code on the scope of store' do
    percentage_discount_item.code = free_discount_item.code
    expect(percentage_discount_item).to be_valid
    percentage_discount_item.store = free_discount_item.store
    expect(percentage_discount_item).to be_invalid
  end

  it 'should validate the presence of code' do
    free_discount_item.code = nil
    expect(free_discount_item).to be_invalid
  end

  it 'should validate either one of free_discount or percentage_discount' do
    free_discount_item.percentage_discount = FactoryBot.create :percentage_discount
    expect(free_discount_item).to be_invalid
  end
end
