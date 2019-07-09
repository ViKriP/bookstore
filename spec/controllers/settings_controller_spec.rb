require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { create(:user) }
  
  before do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe 'GET #show' do
    it do
      get :show
      expect(response).to render_template :show
    end

    it 'responds with success status' do
      get :show
      expect(response.status).to eq(200)
    end
  end
 
  describe 'PATCH #update' do
    before do
      patch :update
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
      patch :update
      expect(flash[:alert]).to eq I18n.t('fail')
    end
  end

  describe 'DELETE #destroy' do
    context 'when user agrees to destroy account' do
      before do
        allow(controller).to receive_message_chain(:params, :[]).and_return(true)
      end

      it 'destroys user' do
        expect { delete :destroy }.to change { User.count }
      end

      it 'redirects to root path' do
        delete :destroy
        expect(response).to redirect_to(root_path)
      end

      it 'sends flash notice' do
        delete :destroy
        expect(flash[:notice]).to eq(I18n.t('destroy_success'))
      end
    end

    context 'when user not agrees to destroy account' do
      before do
        allow(controller).to receive_message_chain(:params, :[]).and_return(false)
      end

      it 'not destroys user' do
        expect { delete :destroy }.not_to change { User.count }
      end

      it 'redirects to settings path' do
        delete :destroy
        expect(response).to redirect_to(settings_path)
      end
    end
  end
end
