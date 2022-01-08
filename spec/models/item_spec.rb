require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.create :item }
  let(:item2) { FactoryBot.create :item }

  it 'should validate the uniqueness of code on the scope of store' do
    item2.code = item.code
    expect(item2).to be_valid
    item2.store = item.store
    expect(item2).to be_invalid
  end

  it 'should validate the presence of code' do
    item.code = nil
    expect(item).to be_invalid
  end
end
