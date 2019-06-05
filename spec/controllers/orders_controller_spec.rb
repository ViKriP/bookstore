require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: order.id }
    end

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end
  end
end
