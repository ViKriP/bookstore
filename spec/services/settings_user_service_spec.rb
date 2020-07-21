require 'rails_helper'

describe SettingsUserService do
  let(:user) { create(:user) }
  let(:params_email) { ActionController::Parameters.new( { user: attributes_for(:user, email: 'test@test.ua'),
                                                           commit: 'email' } ) }
  let(:params_password) { ActionController::Parameters.new( { user: attributes_for(:user, current_password: 'password', password: '2', password_confirmation: '2'),
                                                           commit: 'password' } ) }
  let(:params_info) { ActionController::Parameters.new( { user: attributes_for(:user, first_name: 'Testfirstname', last_name: 'Testlastname'),
                                                           commit: 'info' } ) }

  describe '#call' do
    it 'when user wish to change email' do
      described_class.new(user, params_email).call

      expect(user[:email]).to eql 'test@test.ua'
    end

    it 'when user wish to change password' do
      described_class.new(user, params_password).call

      expect(user.valid_password?('2')).to be(true)
    end

    it 'when user wish to change info' do
      described_class.new(user, params_info).call

      expect(user[:first_name]).to eql 'Testfirstname'
      expect(user[:last_name]).to eql 'Testlastname'
    end
  end
end
