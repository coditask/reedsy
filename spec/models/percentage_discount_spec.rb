require 'rails_helper'

RSpec.describe PercentageDiscount, type: :model do
  let(:percentage_discount) { FactoryBot.create :percentage_discount }
  it 'should validate the presence of minimum_items' do
    percentage_discount.minimum_items = nil
    expect(percentage_discount).to be_invalid
  end

  it 'should validate the presence of discounted_items' do
    percentage_discount.discounted_items = nil
    expect(percentage_discount).to be_invalid
  end

  it 'should validate the presence of percentage' do
    percentage_discount.percentage = nil
    expect(percentage_discount).to be_invalid
  end
end
