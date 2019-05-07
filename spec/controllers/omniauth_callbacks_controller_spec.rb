require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  before { OmniAuth.config.test_mode = true }

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe '#facebook' do
    context 'when success handling' do
      before(:each) do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :facebook)
        get :facebook
      end

      let(:user) { User.find_by(email: 'testuser@facebook.com') }

      it 'should set current_user to proper user' do
        expect(subject.current_user).to eq(user)
      end
    end

    context 'when non-persisting User' do
      before(:each) do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :facebook, :does_not_persist)
        get :facebook
      end

      it 'should redirect to new user registration' do
        expect(response).to redirect_to new_user_registration_url
      end
    end
  end
end