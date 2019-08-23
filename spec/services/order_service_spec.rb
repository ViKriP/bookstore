require 'rails_helper'

describe OrderService, type: :controller do
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

  describe '#order_items' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user_id: user.id) }
    let(:order_item1) { create(:order_item, order_id: order.id, created_at: "2019-08-05 14:50:01".to_time) }
    let(:order_item2) { create(:order_item, order_id: order.id, created_at: "2019-08-05 14:00:01".to_time) }

    it 'returned order_items to the sorted by create_by' do
      user.save
      order.save
      order_item1.save
      order_item2.save

      session[:order_id] = order.id
      order_items = described_class.new(user, session).order_items
      expect(order_items).to be_a ActiveRecord::AssociationRelation
      expect(order_items[0].created_at).to eql "2019-08-05 14:00:01".to_time
    end
  end
end
