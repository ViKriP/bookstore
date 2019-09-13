require 'rails_helper'

describe SettingsUserService do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(SettingsUserService).to receive(:user_params).and_return({})
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

    context 'when user wish to change info' do
      it do
        service = described_class.new(user, { commit: 'info' })
        expect(service).to receive(:user_info)
        service.call
      end
    end

    context 'when user wish to delete self account' do
      it do
        service = described_class.new(user, { delete_confirmation: 'on' })
        expect(service).to receive(:user_destroy)
        service.call
      end
    end
  end

  describe '#user_email' do
    it do
      service = described_class.new(user, { commit: 'email' } )
      expect(user).to receive(:skip_reconfirmation!)
      service.call
    end

    it do
      service = described_class.new(user, { commit: 'email' } )
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

  describe '#user_destroy' do
    it do
      service = described_class.new(user, { delete_confirmation: 'on' })
      expect(user).to receive(:destroy)
      service.call
    end
  end
end
