require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
    session[:order_id] = order.id
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns to @presenter' do
      expect(assigns(:presenter)).to be_a OrdersPresenter
    end

    it 'assigns to @filtered_orders' do
      expect(assigns(:filtered_orders)).to be_a ActiveRecord::Relation
    end
  end
end
