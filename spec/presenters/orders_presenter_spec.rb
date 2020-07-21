require 'rails_helper'

describe OrdersPresenter do
  let(:params_all) { 'all' }
  let(:params_in_queue) { 'in_queue' }
  let(:params_in_delivery) { 'in_delivery' }
  let(:params_delivered) { 'delivered' }
  let(:params_canceled) { 'canceled' }

  describe '#filter_title' do
    OrdersPresenter::ORDER_SORT_TITLES.each do |phrase|
      it "when title '#{phrase[0]}' there is" do
        expect(described_class.new(send("params_#{phrase[0]}")).filter_title).to eq I18n.t("order_filters.#{phrase[0]}")
      end
    end

    context 'When is not params' do
      it do
        expect(described_class.new(nil).filter_title).to eq I18n.t("order_filters.all")
      end
    end

    context 'when the parameter is wrong' do
      it do
        expect(described_class.new('wrong').filter_title).to eq I18n.t("order_filters.all")
      end
    end
  end
end
