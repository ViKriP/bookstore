require 'rails_helper'

describe Orders::IndexPresenter do
  let(:params_all) { { filter: 'all' } }
  let(:params_in_queue) { { filter: 'in_queue' } }
  let(:params_in_delivery) { { filter: 'in_delivery' } }
  let(:params_delivered) { { filter: 'delivered' } }
  let(:params_canceled) { { filter: 'canceled' } }
  let(:orders) { Order.where(id: create_list(:order, 5).map(&:id), state: 'in_delivery') }

  describe '#filter' do
    Orders::IndexPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "returns collection sorted of '#{phrase[0]}'" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filter).to be_a ActiveRecord::Relation
      end
    end
  end

  describe '#filter_title' do
    Orders::IndexPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "when title '#{phrase[0]}' there is" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filter_title).to eq I18n.t("order_filters.#{phrase[0]}")
      end
    end
  end
end
