require 'rails_helper'

RSpec.describe CartController, type: :controller do
  describe 'GET #show' do
    let(:user) { create :user }
    let(:order) { create(:order, user: user) }

    before do
      sign_in user
      session[:order_id] = order.id
      get :show
    end

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the order to @order' do
      expect(assigns(:order).id).to eq(order.id)
    end
  end

  describe 'PUT #update' do
    let(:coupon) { create(:coupon) }

    context 'when invalid coupon code passed' do
      before { put :update }

      it 'redirects to cart page' do
        expect(response).to redirect_to(cart_path)
      end

      it 'sends flash alert' do
        expect(flash[:alert]).to eq(I18n.t('invalid_coupon'))
      end
    end

    context 'when valid coupon code passed' do
      let(:coupon_service) { instance_double('ApplyCouponService') }

      it 'redirects to cart page' do
        put :update
        expect(response).to redirect_to(cart_path)
      end

      it 'sends success notice' do
        put :update, params: { code: coupon.code }
        expect(flash[:notice]).to eq(I18n.t('success_coupon_use'))
      end
    end
  end
end
