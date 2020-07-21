require 'rails_helper'

describe HomepagePresenter do
  let(:presenter) { described_class.new }

  describe '#last_books' do
    let!(:books) { create_list(:book, 7) }

    it 'returns collection' do
      stub_const('HomepagePresenter::CAROUSEL_LIMIT', 3)

      expect(presenter.last_books).to eql(Book.last(3))
    end
  end

  describe '#best_sellers' do
    let(:book) { create(:book) }
    let(:category) { create(:category) }
    let!(:book_category) { create(:book_category, category_id: category.id, book_id: book.id) }
    let(:order) { create(:order, state: 'in_queue' ) }
    let!(:order_item) { create(:order_item, order_id: order.id, book_id: book.id) }

    it 'returns collection' do
      expect(presenter.best_sellers[0].title).to eql(book.title)
    end
  end
end
