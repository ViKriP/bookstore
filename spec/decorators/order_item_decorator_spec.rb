require 'rails_helper'

RSpec.describe OrderItemDecorator do
  let(:order_item) { build_stubbed(:order_item).decorate }

  describe '#order_item_subtotal' do
    it 'returns proper price' do
      expect(order_item.order_item_subtotal).to eq("€#{order_item.subtotal}")
    end
  end
end
