require 'rails_helper'

RSpec.describe CartController, type: :controller do
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item) }
  before { 
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){ nil }
  }

  describe 'GET #show' do
    before do
      allow(order).to receive(:order_items).and_return([order_item])
      allow(controller).to receive(:current_user_order).and_return(order)
      get :show
    end

    it { expect(response).to render_template :show }

    it 'responds with success status' do
      expect(response.status).to eq(200)
    end

    it 'assigns the order to @order' do
      expect(assigns(:order)).to eq order
    end
  end

  describe 'PUT #update' do
    let(:coupon) { create(:coupon) }

    context 'when invalid coupon code passed' do
      before do
        allow(Coupon).to receive(:find_by)
        put :update
      end

      it 'redirects to cart page' do
        expect(response).to redirect_to cart_path
      end

      it 'sends flash alert' do
        expect(flash[:alert]).to eq I18n.t('invalid_coupon')
      end
    end

    context 'when valid coupon code passed' do
      before do
        allow(Coupon).to receive(:find_by).and_return(coupon)
      end

      it 'redirects to cart page' do
        put :update
        expect(response).to redirect_to cart_path
      end

      it 'deactivate current coupon' do
        expect(coupon).to receive(:update)
        put :update
      end

      it 'sends success notice' do
        put :update
        expect(flash[:notice]).to eq I18n.t('success_coupon_use')
      end
    end
  end
end
