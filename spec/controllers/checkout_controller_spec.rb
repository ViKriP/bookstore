require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let!(:user) { create(:user, :with_addresses) }
  let!(:order) { create(:order, user_id: user.id) }
  let!(:order_item) { create(:order_item, order_id: order.id) }
  let!(:delivery) { create(:delivery) }

  before do
    sign_in user
    session[:order_id] = order.id
  end

  describe 'GET #show' do
    %i[address delivery payment confirm complete].each do |step|
      context "when step #{step}" do

        before do
          allow(CheckoutStepSelectService).to receive_message_chain(:new, :check).and_return(step)
          allow(controller).to receive(:checkout_way_is_not_ok?).and_return(true)
          get :show, params: { id: step }
          order.delivery_id = delivery.id if step == :delivery
        end

        it "returns a redirect response" do
          expect(response.status).to eq(302)
        end

        it "redirects on #{step}" do
          expect(response).to redirect_to "/checkout/#{step}"
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:addresses_form) do
      { billing_address_attributes: attributes_for(:address),
        shipping_address_attributes: attributes_for(:address) }
    end
    let(:checkout_service) { instance_double('CheckoutService') }
    let(:delivery) { create(:delivery) }

    %i[address delivery payment confirm].each do |step|
      context "when step #{step}" do

        before do
          case step
          when :address then param_arg = { id: step, order: addresses_form }
          when :delivery then param_arg = { id: step, order: { delivery_id: delivery.id } }
          when :payment then param_arg = { id: step, order: { credit_card_attributes: attributes_for(:credit_card) } }
          when :confirm then param_arg = { id: step }
          end

          put :update, params: param_arg
        end

        it "returns a redirect response" do
          expect(response).to have_http_status(302)
        end

        it "redirect path" do
          expect(response).to redirect_to "/checkout/#{controller.next_step}"
        end

        it "method was called - process_#{step}" do
          method_step = "process_#{step}"

          expect(checkout_service).to receive(method_step.to_sym)
          checkout_service.public_send(method_step)
        end
      end
    end
  end
end
