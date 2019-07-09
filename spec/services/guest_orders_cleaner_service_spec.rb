require 'rails_helper'

describe GuestOrdersCleanerService do
  describe '#call' do
    let(:order_without_user) { create(:order, user_id: nil) }
    let(:order_item2) { create(:order_item, order_id: order_without_user.id) }

    let(:guest_session_id) { '91674c338189b80bc6a5d09e2c459ca6' }
    let(:current_user) { create(:user) }
    let(:order) { create(:order, user_id: current_user.id) }
    let(:order_item) { create(:order_item, order_id: order.id) }
    
    let(:guest_order) { create(:guest_order, guest_id: guest_session_id, order_id: order_without_user.id) }
    let(:guest_order_bad) { create(:guest_order, guest_id: guest_session_id, order_id: order_without_user.id, created_at: Time.now - 1.day) }

    let(:service) { described_class.new(current_user, guest_session_id) }

    context 'when a guest is logged in' do
      it 'when guest order there is and user order there is' do
        allow(Order).to receive(:create).and_return(order)
        allow(OrderItem).to receive(:create).and_return(order_item)

        allow(Order).to receive(:create).and_return(order_without_user)
        allow(OrderItem).to receive(:create).and_return(order_item2)
        allow(GuestOrder).to receive(:create).and_return(guest_order)

        g_order = guest_order
        ord = order_without_user

        service.call

        expect(GuestOrder.find_by_id(g_order)).to be_nil
        expect(Order.find_by_id(ord)).to be_nil
      end

      it 'when guest order there is and user order there is but without item' do
        allow(Order).to receive(:create).and_return(order)

        allow(Order).to receive(:create).and_return(order_without_user)
        allow(OrderItem).to receive(:create).and_return(order_item2)
        allow(GuestOrder).to receive(:create).and_return(guest_order)

        g_order = guest_order
        ord = order_without_user

        service.call

        expect(GuestOrder.find_by_id(g_order)).to be_nil
        expect(Order.find_by_id(ord)).to be_nil
      end
    end

    context 'guest order outdated' do
      it do
        allow(Order).to receive(:create).and_return(order_without_user)
        allow(OrderItem).to receive(:create).and_return(order_item2)
        allow(GuestOrder).to receive(:create).and_return(guest_order_bad)

        g_order = guest_order_bad
        ord = order_without_user

        service.call

        expect(GuestOrder.find_by_id(g_order)).to be_nil
        expect(Order.find_by_id(ord)).to be_nil
      end
    end
  end
end
