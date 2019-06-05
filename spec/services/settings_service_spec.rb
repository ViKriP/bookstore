require 'rails_helper'

describe SettingsService do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(SettingsService).to receive(:user_params).and_return({})
  end

  describe '#call' do
    context 'when user wish to change email' do
      it do
        service = described_class.new(user, { commit: 'email' })
        expect(service).to receive(:user_email)
        service.call
      end
    end

    context 'when user wish to change password' do
      it do
        service = described_class.new(user, { commit: 'password' })
        expect(service).to receive(:user_password)
        service.call
      end
    end

    context 'when user wish to change billing address' do
      it do
        service = described_class.new(user, { commit: 'billing_address' })
        expect(service).to receive(:user_billing_address)
        service.call
      end
    end

    context 'when user wish to change shipping address' do
      it do
        service = described_class.new(user, { commit: 'shipping_address' })
        expect(service).to receive(:user_shipping_address)
        service.call
      end
    end
  end

  describe '#user_email' do
    it do
      service = described_class.new(user, { commit: 'email' })
      expect(user).to receive(:skip_reconfirmation!)
      service.call
    end

    it do
      service = described_class.new(user, { commit: 'email' })
      expect(user).to receive(:update)
      service.call
    end
  end

  describe '#user_info' do
    it do
      service = described_class.new(user, { commit: 'info' })
      expect(user).to receive(:update)
      service.call
    end
  end

  describe '#user_password' do
    it do
      service = described_class.new(user, { commit: 'password' })
      expect(user).to receive(:update_with_password)
      service.call
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
