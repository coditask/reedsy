require 'rails_helper'

RSpec.describe FreeDiscount, type: :model do
  let(:free_discount) { FactoryBot.create :free_discount }
  it 'should validate the presence of minimum_items' do
    free_discount.minimum_items = nil
    expect(free_discount).to be_invalid
  end

  it 'should validate the presence of free_items' do
    free_discount.free_items = nil
    expect(free_discount).to be_invalid
  end
end
