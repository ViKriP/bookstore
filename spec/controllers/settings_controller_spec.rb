require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { create(:user) }
  
  before do
    sign_in user
  end

  describe 'PATCH #address' do
    before do
      patch :address
    end
 
    it { expect(response).to redirect_to settings_path }

    it 'sends flash notice' do
      expect(flash[:notice]).to eq I18n.t('update_success')
    end

    it 'returns 302 http status' do
      expect(response.status).to eq(302)
    end

    it 'sends error alert' do
      allow(SettingsAddressService).to receive_message_chain(:new, :call).and_return(false)
      patch :address

      expect(flash[:alert]).to eq I18n.t('fail')
    end
  end

  describe 'PATCH #user' do
    before do
      patch :user, params: { user: { email: 'test@test.ua'}, commit: 'email' }
    end

    it { expect(response).to redirect_to settings_path }

    it 'sends flash notice' do
      expect(flash[:notice]).to eq I18n.t('update_success')
    end

    it 'returns 302 http status' do
      expect(response.status).to eq(302)
    end

    it 'sends error alert' do
      allow(user).to receive(:valid?).and_return(false)
      patch :user

      expect(flash[:alert]).to eq I18n.t('fail')
    end

    it 'delete user' do
      patch :user, params: { delete_confirmation: 'on' }

      expect(flash[:notice]).to eq I18n.t('destroy_success')
    end
  end
end
