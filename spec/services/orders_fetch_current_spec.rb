require 'rails_helper'

describe Orders::FetchCurrent do
  let(:session) { 'bf5cc77ea7f77bf9a0dac3354beda98a' }

  describe '#call' do
    let(:user) { create(:user) }

    context 'When user is logged and he is order' do
      let(:order) { create(:order, user_id: user.id) }

      it 'returned order' do
        user_order = described_class.new(user, order.id, session).call
        expect(user_order).to be_a Order
      end
    end

    context 'When guest and he is order' do
      let(:order) { create(:order)}

      it 'returned order' do
        user_order = described_class.new(nil, order.id, session).call
        expect(user_order).to be_a Order
      end
    end

    context "When guest and he isn't order" do
      it 'returned new order' do
        user_order = described_class.new(user, nil, session).call
        expect(user_order).to be_a Order
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
      
      order_items = described_class.new(user, order.id, session).order_items
      expect(order_items).to be_a ActiveRecord::AssociationRelation
      expect(order_items[0].created_at).to eql "2019-08-05 14:00:01".to_time
    end
  end
end
