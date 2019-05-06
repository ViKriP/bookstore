require 'rails_helper'

describe CheckoutService do
  let(:order) { create(:order) }
  let(:params) { {} }

  describe '#add_addresses' do
    let(:subject) { described_class.new(order, params) }

    it 'creates addresses for order' do
      allow(subject).to receive(:billing_address_params)
      allow(subject).to receive(:shipping_address_params)
      subject.add_addresses
    end
  end

  describe '#add_delivery' do
    let(:subject) { described_class.new(order, params) }

    it 'calls update on order' do
      allow(subject).to receive(:order_delivery_params)
      expect(order).to receive(:update)
      subject.add_delivery
    end
  end

  describe '#add_card' do
    let(:subject) { described_class.new(order, params) }

    it 'creates credit card for order' do
      allow(subject).to receive(:card_params)
      expect(order).to receive(:create_credit_card)
      subject.add_card
    end
  end
end