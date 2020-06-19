require 'rails_helper'

describe Books::BestSellersQuery do
  describe '#call' do
    context 'when there is at least one category' do
      let(:categories) { create_list(:category, Books::BestSellersQuery::BESTSELLERS_LIMIT) }
      let(:books) { create_list(:book, 5) }
      let(:order_1) { create(:order, state: 'in_queue') }
      let(:order_2) { create(:order, state: 'in_queue') }

      def fill_catalog_books(items)
        bestsellers = []

        (0..items-1).each do |item|
          create(:book_category, category_id: categories[item].id, book_id: books[item].id)
          create(:order_item, order_id: order_1.id, book_id: books[item].id, quantity: 1)

          bestsellers.push(books[item]) if item > 0
        end

        create(:book_category, category_id: categories[0].id, book_id: books[4].id)
        create(:order_item, order_id: order_2.id, book_id: books[4].id, quantity: 2)

        bestsellers.push(books[4]).sort
      end

      (1..Books::BestSellersQuery::BESTSELLERS_LIMIT).each do |number|
        it "returns bestsellers of #{number}st category" do
          bestsellers = fill_catalog_books(number)

          expect(described_class.new.call.sort).to eq(bestsellers)
        end
      end
    end

    context "when aren't any categories" do
      it 'returns nil' do
        expect(described_class.new.call).to be_nil
      end
    end

    context "when there is any category, but not a single bestseller" do
      let(:category) { create(:category) }
      let(:book) { create(:book) }
      let!(:book_category) { create(:book_category, category_id: category.id, book_id: book.id) }

      it 'returns nil' do
        expect(described_class.new.call).to be_nil
      end
    end 
  end
end
