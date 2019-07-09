require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user_id: user.id) }
  let!(:order_item) { create(:order_item, order_id: order.id) }

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_user_order).and_return(order)
    session[:order_id] = order.id
  end

  describe 'GET #show' do
    %i[address delivery payment confirm complete].each do |step|
      before { get :show, params: { id: step } }
      context "when step #{step}" do

        it 'return a redirect response' do
          expect(response.status).to eq(302)
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'when step address' do
      let(:addresses_form) do
        { billing_address_attributes: attributes_for(:address),
          shipping_address_attributes: attributes_for(:address) }
      end

      it 'return a redirect response' do
        put :update, params: { id: :address, order: addresses_form }
        expect(response).to have_http_status(302)
      end
    end

    context 'when step delivery' do
      let(:delivery) { create(:delivery) }

      it 'return a redirect response' do
        put :update, params: { id: :delivery, order: { delivery_id: delivery.id } }
        expect(response).to have_http_status(302)
      end
    end

    context 'when step payment' do
      let(:param) { {id: :payment, order: { credit_card_attributes: attributes_for(:credit_card)} } }

      it 'return a redirect response' do
        put :update, params: param
        expect(response).to have_http_status(302)
      end
    end

    context 'when step confirm' do
      it 'return a redirect response' do
        put :update, params: { id: :confirm }
        expect(response).to have_http_status(302)
      end
    end
  end

end
