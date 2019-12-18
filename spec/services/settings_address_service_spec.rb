require 'rails_helper'

describe SettingsAddressService do
  let(:user_with_addresses) { create(:user, :with_addresses) }
  let(:user_without_addresses) { create(:user) }
  let(:params_billing_address) { ActionController::Parameters.new( { user: { billing_address: attributes_for(:address, first_name: 'Testname') },
                                                                     commit: 'billing_address' } ) }
  let(:params_shipping_address) { ActionController::Parameters.new( { user: { shipping_address: attributes_for(:address, first_name: 'Testname') },
                                                                     commit: 'shipping_address' } ) }

  describe '#call' do
    context 'when the address (billing/shipping) is already there' do
      it 'billing address is updated' do
        described_class.new(user_with_addresses, params_billing_address).call

        expect(user_with_addresses.billing_address[:first_name]).to eql 'Testname'
      end

      it 'shipping address is updated' do
        described_class.new(user_with_addresses, params_shipping_address).call

        expect(user_with_addresses.shipping_address[:first_name]).to eql 'Testname'
      end
    end

    context 'when user has no address (billing/shipping) address yet' do
      it 'billing address is created' do
        described_class.new(user_without_addresses, params_billing_address).call

        expect(user_without_addresses.billing_address[:first_name]).to eql 'Testname'
      end

      it 'shipping address is created' do
        described_class.new(user_without_addresses, params_shipping_address).call

        expect(user_without_addresses.shipping_address[:first_name]).to eql 'Testname'
      end
    end
  end
end
