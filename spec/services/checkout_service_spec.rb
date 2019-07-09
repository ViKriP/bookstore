require 'rails_helper'

describe CheckoutService do
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }
  let(:order) { create(:order, delivery_id: delivery.id, credit_card_id: credit_card.id) } #, delivery_id: '2', credit_card_id: '4'
  let(:params_card) { { order: { credit_card_attributes: { last4: '1111', name: 'Gold', exp_month: '10', exp_year: '20' } } } }
  let(:params_delivery) { { order: { delivery_id: delivery.id } } }
  let(:params_address_billing) { { use_billing: 'true',
                                   order: { billing_address_attributes: { first_name: '1', last_name: 'Gold', address: '10', zip: '20', city: 'den', country: 'UA', phone: '+380991112233' },
                                            shipping_address_attributes: { first_name: '2', last_name: 'Gold', address: '10', zip: '20', city: 'den', country: 'UA', phone: '+380991112233' } } } }
  let(:params_address_shipping) { { use_billing: 'false',
                                    order: { billing_address_attributes: { first_name: '3', last_name: 'Gold', address: '10', zip: '20', city: 'den', country: 'UA', phone: '+380991112233' },
                                             shipping_address_attributes: { first_name: '4', last_name: 'Gold', address: '10', zip: '20', city: 'den', country: 'UA', phone: '+380991112233' } } } }

  describe '#add_addresse' do
    context 'when shipping address is billing address' do
      let(:subject) { described_class.new(order, ActionController::Parameters.new(params_address_billing)) }

      it do
        tmp = subject.add_addresses
        expect(order.shipping_address.first_name).to eq '1'
      end
    end

    context "when shipping address isn't billing address" do
      let(:subject) { described_class.new(order, ActionController::Parameters.new(params_address_shipping)) }

      it do
        tmp = subject.add_addresses
        expect(order.shipping_address.first_name).to eq '4'
      end
    end
  end

  describe '#add_delivery' do
    let(:subject) { described_class.new(order, ActionController::Parameters.new(params_delivery)) }

    it 'calls update on order' do
      order_tmp = subject.add_delivery

      expect(order_tmp).to be true
      expect(order.delivery_id).to eq delivery.id
    end
  end

  describe '#add_card' do
    let(:subject) { described_class.new(order, ActionController::Parameters.new(params_card)) }

    it 'creates credit card for order' do
      card = subject.add_card

      expect(card.name).to eq 'Gold'
    end
  end
end