require 'rails_helper'
include ItemHelper

RSpec.describe 'ItemHelper' do
  describe '#formatted_price' do
    it 'should format the number in the currency' do
      assign :total, BigDecimal(100)
      expect(helper.formatted_price).to eq '1.00€'
    end
  end
end
