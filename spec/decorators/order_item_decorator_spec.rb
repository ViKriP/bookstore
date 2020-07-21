require 'rails_helper'

RSpec.describe OrderItemDecorator do
  let(:order_item) { build_stubbed(:order_item).decorate }

  describe '#order_item_subtotal' do
    it 'returns proper price' do
      expect(order_item.order_item_subtotal).to eq("€#{order_item.subtotal}")
    end
  end

  describe '#subtotal' do
    it 'returns total price for item' do
      expect(order_item.subtotal).to eq(order_item.book.price * order_item.quantity)
    end
  end
end
