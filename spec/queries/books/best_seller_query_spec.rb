require 'rails_helper'

describe Books::BestSellersQuery do
  describe '#call' do
    let(:categories) { create_list(:category, 4) }
    let(:books) { create_list(:book, 5) }
    let(:order_1) { create(:order, state: 'in_queue') }
    let(:order_2) { create(:order, state: 'in_queue') }

    def fill_catalog_books(items)
      bestseller = []

      (0..items-1).each do |item|
        create(:book_category, category_id: categories[item].id, book_id: books[item].id)
        create(:order_item, order_id: order_1.id, book_id: books[item].id, quantity: 1)
        bestseller.push(books[item]) if item > 0
      end

      create(:book_category, category_id: categories[0].id, book_id: books[4].id)
      create(:order_item, order_id: order_2.id, book_id: books[4].id, quantity: 2)

      bestseller.push(books[4]).sort
    end

    (1..4).each do |number|
      it "returns #{number} bestsellers" do
        bestsellers = fill_catalog_books(number)

        expect(described_class.new.call.sort).to eq(bestsellers)
      end
    end
  end
end
