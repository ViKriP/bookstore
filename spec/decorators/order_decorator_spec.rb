require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:order) { build_stubbed(:order).decorate }
  let(:order_item) { build_stubbed(:order_item, order_id: order.id, book_id: book.id).decorate }
  let(:book) { build_stubbed(:book).decorate }

  describe "#order_date" do
    it 'returns proper price' do
      expect(order.order_date).to eq(order.created_at.strftime('%B %d, %Y'))
    end    
  end

  describe "#order_subtotal" do
    it 'returns proper price' do
      expect(order.order_subtotal).to eq('€0.00')
    end    
  end

  describe "#order_discount" do
    it 'returns proper price' do
      expect(order.order_discount).to eq('€1.00')
    end    
  end

  describe "#order_total" do
    it 'returns proper price' do
      expect(order.order_total).to eq('€1.00')
    end    
  end

  describe "#delivery_price" do
    let(:delivery) { create(:delivery) }

    it 'when no delivery' do
      expect(order.delivery_price).to eq('€0.00')
    end

    it 'when delivery there is' do
      allow(order).to receive(:delivery).and_return delivery
      expect(order.delivery_price).to eq('€1.55')
    end
  end

  describe '#subtotal' do
    context 'when delivery already added' do
      it 'returns total price for all containing items including delivery price' do
        expect(order.subtotal).to eq(order.order_items.joins(:book).sum('books.price * order_items.quantity'))
      end
    end

    context 'when delivery did not added yet' do
      it 'returns total price for all containing items' do
        allow(order).to receive(:delivery).and_return(nil)
        expect(order.subtotal).to eq(order.order_items.joins(:book).sum('books.price * order_items.quantity'))
      end
    end
  end

  describe '#total' do
    before do
      allow(order).to receive(:delivery).and_return(nil)
    end

    context "when discount is less than order's subtotal" do
      it 'returns the price at a discount' do
        allow(order).to receive(:subtotal).and_return(10)
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
    let(:order) { create(:order) }
    let(:book) { create(:book) }

    context 'when book had not added' do
      it do
        new_item = create(:order_item, order_id: order.id)

        expect(order.decorate.book_added?(book.id)).to eq false
      end
    end

    context 'when book added' do
      it do
        new_item = create(:order_item, order_id: order.id, book_id: book.id)

        expect(order.decorate.book_added?(book.id)).to eq true
      end
    end
  end
end
