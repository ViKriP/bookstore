require 'rails_helper'

describe Orders::IndexPresenter do
  let(:params_all) { { filter: 'all' } } #I18n.t('all_orders')
  let(:params_in_queue) { { filter: 'in_queue' } } # I18n.t('order_filters.waits')
  let(:params_in_delivery) { { filter: 'in_delivery' } } # I18n.t('order_filters.in_delivery')
  let(:params_delivered) { { filter: 'delivered' } } # I18n.t('order_filters.delivered')
  let(:params_canceled) { { filter: 'canceled' } } # I18n.t('order_filters.canceled')

  describe '#filter' do
    #let(:params_with_filter) { { sort_with: 'title desc' } }
    let(:orders) { Order.where(id: create_list(:order, 5).map(&:id), state: 'in_delivery') }
    #let(:order) { create(:order, state: 'in_delivery') }

    #book = create(:book, quantity: 0)

    Orders::IndexPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "returns collection sorted of #{phrase[0]}" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filter).to be_a ActiveRecord::Relation
      end
    end

    Orders::IndexPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "returns collection sorted of #{phrase[0]}" do
        expect(described_class.new(orders, send("params_#{phrase[0]}")).filter_title).to eq I18n.t("order_filters.#{phrase[0]}")
      end
    end

    it do
      expect(described_class.new(orders, params_in_delivery).filter_title).to eql 'In delivery'
    end

    #xit 'returns collection' do
      #create_list(:book, 5)
      #expect(BookSortingService.new(params_with_filter).sort(Book.all)).to be_a ActiveRecord::Relation
    #end
  end

  describe '#filter_title' do
    it do
    end
  end
end
