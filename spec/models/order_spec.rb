require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item) }

  before { allow(order).to receive(:order_items).and_return([order_item]) }

  it { is_expected.to have_many(:order_items).dependent(:destroy) }
  #it { is_expected.to have_one(:billing_address).dependent(:destroy) }
  #it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:delivery) }
  it { is_expected.to belong_to(:credit_card) }

  describe '#subtotal' do
    context 'when delivery already added' do
      it 'returns total price for all containing items including delivery price' do
        expect(order.subtotal).to eq(order.order_items.map(&:subtotal).sum)
      end
    end

    context 'when delivery did not added yet' do
      it 'returns total price for all containing items' do
        allow(order).to receive(:delivery).and_return(nil)
        expect(order.subtotal).to eq(order.order_items.map(&:subtotal).sum)
      end
    end
  end

  describe '#total' do
    before do
      allow(order).to receive(:delivery).and_return(nil)
    end

    context "when discount is less than order's subtotal" do
      it 'returns the price at a discount' do
        expect(order.total).to eq(order.subtotal - order.discount)
      end
    end

    context "when discount is higher than order's subtotal" do
      it 'returns 1 eur' do
        allow(order).to receive(:subtotal).and_return(order.discount)
        expect(order.total).to eq 1
      end
    end
  end

  describe '#book_added?' do
    context 'when new book in cart' do
      it do
        new_item = create(:order_item)
        expect(order.book_added?(new_item.book.id)).to eq false
      end
    end

    context 'when book alreadt added' do
      it do
        expect(order.book_added?(order_item.book.id)).to eq true
      end
    end
  end

  describe '#track_number' do
    it 'returns formatted order id' do
      expect(order.track_number).to eq("R#{order.id}")
    end
  end
end
