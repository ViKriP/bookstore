require 'rails_helper'

describe OrderSessionService, type: :controller do
  describe '#call' do
    let(:user) { create(:user) }

    context 'When user is logged and he is order' do
      let(:order) { create(:order, user_id: user.id) }

      it 'returned order' do
        session[:order_id] = order.id
        service = described_class.new(user, session).call
        expect(service).to be_a Order
        expect(service.id).to eql order.id
      end
    end

    context 'When guest and he is order' do
      let(:order) { create(:order)}

      it 'returned order' do
        session[:order_id] = order.id
        service = described_class.new(nil, session).call
        expect(service).to be_a Order
      end
    end

    context "When guest and he isn't order" do
      it 'returned new order' do
        session[:order_id] = nil
        service = described_class.new(user, session).call
        expect(service).to be_a Order
      end
    end
  end
end
