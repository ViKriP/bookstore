require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  before { OmniAuth.config.test_mode = true }

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#facebook' do
    context 'When user with such email does not exist' do
      let(:user) { create(:auth_hash, :facebook) }

      before(:each) do
        request.env['omniauth.auth'] = user
        get :facebook
      end

      it 'should set current_user to proper user' do
        expect(subject.current_user).to eql User.find_by(email: user.info[:email])

        expect(User.all.count).to eql 1
      end

      it 'user was signed in' do
        expect(subject.current_user[:email]).to eql user.info[:email]
      end

      it 'order was added to user' do
        expect(subject.current_user.orders.count).to eql 1
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end

      it 'sends success notice' do
        expect(flash[:notice]).to eq I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
      end
    end

    context 'When user with such email exists' do
      let(:user_incoming) { create(:auth_hash, :facebook) }
      let!(:user) { create(:user, provider:'facebook',
                                  uid: user_incoming.info[:uid],
                                  email: user_incoming.info[:email],
                                  first_name: user_incoming.info[:first_name],
                                  last_name: user_incoming.info[:last_name],) }

      before(:each) do
        request.env['omniauth.auth'] = user_incoming
        get :facebook
      end

      it 'user incoming is not created' do
        expect(User.all.count).to eql 1
      end

      it 'user was signed in' do
        expect(subject.current_user[:email]).to eql user_incoming.info[:email]
      end

      it 'order was added to user' do
        expect(subject.current_user.orders.count).to eql 1
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end

      it 'sends success notice' do
        expect(flash[:notice]).to eq I18n.t('devise.omniauth_callbacks.success', kind: 'Facebook')
      end
    end

    context "When user can't be persisted" do
      before(:each) do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :facebook, :does_not_persist)
        get :facebook
      end

      it 'should redirect to new user registration' do
        expect(response).to redirect_to new_user_registration_url
      end
    end
  end

  describe '#Failure' do
    before(:each) do
      request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :facebook, :does_not_persist)
      get :failure
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_path
    end
  end
end
