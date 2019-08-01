require 'rails_helper'

describe AddressesPresenter do
  let(:user) { create(:user) }

  describe '#addresses' do
    let(:billing_address) { create(:address) }
    let(:shipping_address) { create(:address) }

    it 'when addresses there is' do
      user.build_billing_address(billing_address.attributes)
      user.build_shipping_address(shipping_address.attributes)

      described_class.new(user).addresses

      expect(user.billing_address.address).to eql billing_address.address
      expect(user.shipping_address.address).to eql shipping_address.address
    end
  end

  describe '#addresses' do
    it "when aren't addresses" do
      described_class.new(user).addresses

      expect(user.billing_address).to be_a BillingAddress
      expect(user.shipping_address).to be_a ShippingAddress
    end
  end
end
