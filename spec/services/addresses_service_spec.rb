require 'rails_helper'

describe AddressesService do
  let(:user) { create(:user) }

  describe '#call' do
    let(:billing_address) { create(:address) }
    let(:shipping_address) { create(:address) }

    it 'when addresses there is' do
      user.build_billing_address(billing_address.attributes)
      user.build_shipping_address(shipping_address.attributes)

      described_class.new(user).call

      expect(user.billing_address.address).to eql billing_address.address
      expect(user.shipping_address.address).to eql shipping_address.address
    end
  end

  describe '#call' do
    it "when aren't addresses" do
      described_class.new(user).call

      expect(user.billing_address).to be_a BillingAddress
      expect(user.shipping_address).to be_a ShippingAddress
    end
  end
end
