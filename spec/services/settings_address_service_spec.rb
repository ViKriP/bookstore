require 'rails_helper'

describe SettingsAddressService do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(SettingsAddressService).to receive(:user_params).and_return({})
  end

  describe '#call' do
    context 'when user wish to change billing address' do
      it do
        service = described_class.new(user, { commit: 'billing_address' })
        expect(service).to receive(:billing_address)
        service.call
      end
    end

    context 'when user wish to change shipping address' do
      it do
        service = described_class.new(user, { commit: 'shipping_address' })
        expect(service).to receive(:shipping_address)
        service.call
      end
    end
  end

  describe '#user_billing_address' do
    context 'when user has no billing address yet' do
      it do
        service = described_class.new(user, { commit: 'billing_address' })
        expect(user).to receive(:create_billing_address)
        service.call
      end
    end

    context 'when user has billing address' do
      it do
        user.billing_address = create(:billing_address)
        service = described_class.new(user, { commit: 'billing_address' })
        expect(user.billing_address).to receive(:update)
        service.call
      end
    end
  end

  describe '#user_shipping_address' do
    context 'when user has no shipping address yet' do
      it do
        service = described_class.new(user, { commit: 'shipping_address' })
        expect(user).to receive(:create_shipping_address)
        service.call
      end
    end

    context 'when user has shipping address' do
      it do
        user.shipping_address = create(:shipping_address)
        service = described_class.new(user, { commit: 'shipping_address' })
        expect(user.shipping_address).to receive(:update)
        service.call
      end
    end
  end
end
