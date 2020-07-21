require 'rails_helper'

describe BookCategoryService do
  let!(:book) { create(:book) }

  context 'when a book belongs to a category' do
    let(:category) { create(:category) }
    let!(:book_category) { create(:book_category, book_id: book.id, category_id: category.id) }

    it 'returns category id of book' do
      expect(book.categories.first.id).to eq(category.id)
    end
  end

  context 'when a book is not belongs any to a category' do
    it 'returns a blank list categories for the book' do
      expect(book.categories).to be_blank
    end
  end
end
