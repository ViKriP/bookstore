require 'rails_helper'

describe OrdersPresenter do
  let(:params_all) { 'all' }
  let(:params_in_queue) { 'in_queue' }
  let(:params_in_delivery) { 'in_delivery' }
  let(:params_delivered) { 'delivered' }
  let(:params_canceled) { 'canceled' }
  let(:orders) { Order.where(id: create_list(:order, 5).map(&:id), state: 'in_delivery') }

  describe '#filtered_orders' do
    OrdersPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "returns collection sorted of '#{phrase[0]}'" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filtered_orders).to be_a ActiveRecord::Relation
      end
    end

    context "When aren't params" do
      it do
        expect(described_class.new(orders, nil).filtered_orders).to be_a ActiveRecord::Relation
      end
    end

    context "When aren't orders" do
      it do
        expect(described_class.new(nil, nil).filtered_orders).to be_nil
      end
    end
  end

  describe '#filter_title' do
    OrdersPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "when title '#{phrase[0]}' there is" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filter_title).to eq I18n.t("order_filters.#{phrase[0]}")
      end
    end

    context "When aren't params" do
      it do
        expect(described_class.new(orders, nil).filter_title).to eq I18n.t("order_filters.all")
      end
    end
  end
end
