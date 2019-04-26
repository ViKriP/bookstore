require 'rails_helper'

describe BookDecorator do
  let(:delivery) { build_stubbed(:delivery).decorate }

  describe '#delivery_price' do
    it 'returns proper delivery price' do
      expect(delivery.delivery_price).to eq("€#{delivery.price.round(2)}")
    end
  end
end