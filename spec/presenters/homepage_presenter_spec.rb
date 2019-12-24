require 'rails_helper'

describe HomepagePresenter do
  describe '#last_books' do
    let!(:books) { create_list(:book, 7) }

    it 'returns collection' do
      expect(described_class.new.last_books.sort).to eql [ books[4], books[5], books[6] ]
    end
  end

  describe '#best_sellers' do
    it 'returns collection' do
      expect(described_class.new.best_sellers).to be_a Array
    end
  end
end
