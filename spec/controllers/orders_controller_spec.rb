require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  let(:order) { create(:order, user: user) }
  let!(:order_in_queue) { create(:order, user: user, state: 'in_queue') }

  before do
    sign_in user
    session[:order_id] = order.id
  end

  describe 'GET #index' do
    before do
      get :index, params: { filter: 'in_queue' }
    end

    it { expect(response).to render_template :index }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns to @presenter' do
      expect(assigns(:presenter).filter_title).to eql I18n.t('order_filters.in_queue')
    end

    it 'assigns to @filtered_orders' do
      expect(assigns(:filtered_orders).first.id).to eql order_in_queue.id
    end
  end
end
