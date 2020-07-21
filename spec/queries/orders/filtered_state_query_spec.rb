require 'rails_helper'

describe Orders::FilteredStateQuery do
  let(:user) { create(:user)}
  let!(:order_1) { create(:order, state: 'in_queue', user_id: user.id) }
  let!(:order_2) { create(:order, state: 'in_delivery', user_id: user.id) }
  let!(:order_3) { create(:order, state: 'delivered', user_id: user.id) }
  let!(:order_4) { create(:order, state: 'canceled', user_id: user.id) }

  describe '#call' do
    context 'When filtered are orders' do
      OrdersPresenter::ORDER_SORT_TITLES.each do |phrase|
        it "returns collection sorted of '#{phrase[0]}'" do

          phrase[0].to_s == 'all' ?
            result = user.orders.where.not(state: 'in_progress').all :
            result = user.orders.where(state: phrase[0].to_s).all

          expect(described_class.new(user.orders, phrase[0].to_s).call.all).to eq result
        end
      end
    end

    context "When aren't params" do
      it 'filter is nil' do
        expect(described_class.new(user.orders, nil).call.all).to eq user.orders.where.not(state: 'in_progress').all
      end
    end

    context "When aren't orders" do
      it 'orders are nil' do
        expect(described_class.new(nil, nil).call).to be_nil
      end
    end
  end
end
