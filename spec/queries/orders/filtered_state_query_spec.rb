require 'rails_helper'

describe Orders::FilteredStateQuery do
  let(:params_all) { 'all' }
  let(:params_in_queue) { 'in_queue' }
  let(:params_in_delivery) { 'in_delivery' }
  let(:params_delivered) { 'delivered' }
  let(:params_canceled) { 'canceled' }
  let(:orders) { Order.where(id: create_list(:order, 5).map(&:id), state: 'in_delivery') }

  describe '#filtered_orders' do
    OrdersPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "returns collection sorted of '#{phrase[0]}'" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).call).to be_a ActiveRecord::Relation
      end
    end

    context "When aren't params" do
      it do
        expect(described_class.new(orders, nil).call).to be_a ActiveRecord::Relation
      end
    end

    context "When aren't orders" do
      it do
        expect(described_class.new(nil, nil).call).to be_nil
      end
    end
  end
end
