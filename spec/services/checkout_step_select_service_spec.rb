require 'rails_helper'

describe CheckoutStepSelectService do
  let(:order) { create(:order) }
  let(:address) { create(:address) }
  let(:billing_address) { create(:billing_address) }
  let(:shipping_address) { create(:shipping_address) }
  

  describe '#check' do
    context 'when the address is missing' do
      it 'return :address' do
        service = described_class.new(order)
        expect(service.check).to eq :address
      end
    end

    context 'when the delivery is missing' do
      it 'return :delivery' do
        order.create_billing_address
        order.create_shipping_address

        service = described_class.new(order)
        expect(service.check).to eq :delivery
      end
    end

    context 'when the credit_card is missing' do
      it 'return :payment' do
        order.create_billing_address
        order.create_shipping_address
        order.create_delivery

        service = described_class.new(order)
        expect(service.check).to eq :payment
      end
    end

    context 'when the confirm is missing' do
      it 'return :confirm' do
        order.create_billing_address
        order.create_shipping_address
        order.create_delivery
        order.create_credit_card
        
        service = described_class.new(order)
        expect(service.check).to eq :confirm
      end
    end

    context 'when complete' do
      it 'return :complete' do
        order.create_billing_address
        order.create_shipping_address
        order.create_delivery
        order.create_credit_card
        order.state = 'in_queue'
        
        service = described_class.new(order)
        expect(service.check).to eq :complete
      end
    end
  
  end
end