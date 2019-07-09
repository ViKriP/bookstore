require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:order) { build_stubbed(:order).decorate }

  describe "#order_date" do
    it 'returns proper price' do
      expect(order.order_date).to eq(order.created_at.strftime('%B %d, %Y'))
    end    
  end

  describe "#order_subtotal" do
    it 'returns proper price' do
      expect(order.order_subtotal).to eq('€0.00')
    end    
  end

  describe "#order_discount" do
    it 'returns proper price' do
      expect(order.order_discount).to eq('€1.00')
    end    
  end

  describe "#order_total" do
    it 'returns proper price' do
      expect(order.order_total).to eq('€1.00')
    end    
  end

  describe "#delivery_price" do
    let(:delivery) { create(:delivery) }

    it 'when no delivery' do
      expect(order.delivery_price).to eq('€0.00')
    end

    it 'when delivery there is' do
      allow(order).to receive(:delivery).and_return delivery
      expect(order.delivery_price).to eq('€1.55')
    end
  end
end
