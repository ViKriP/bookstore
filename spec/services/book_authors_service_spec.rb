require 'rails_helper'

describe BookAuthorsService do
  let!(:book) { create(:book) }

  context 'when a book has at least one author' do
    let(:authors) { create_list(:author, 2) }

    it 'returns list id authors of book' do
      authors.each { |author|
        create(:book_author, book_id: book.id, author_id: author.id)
      }

      expect(book.authors).to eq(authors)
    end
  end

  context 'when a book has not any one author' do
    it 'returns a blank list id authors for the book' do
      expect(book.authors).to be_blank
    end
  end
end
