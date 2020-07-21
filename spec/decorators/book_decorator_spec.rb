require 'rails_helper'

RSpec.describe BookDecorator do
  let(:book) { build_stubbed(:book).decorate }

  describe '#book_price' do
    it 'returns proper price' do
      expect(book.book_price).to eq("€#{book.price}")
    end
  end

  describe '#book_authors' do
    it "returns string with formatted authors' names" do
      proper_format = book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
      expect(book.book_authors).to eq(proper_format)
    end
  end

  describe '#book_dimensions' do
    it 'returns string with formatted dimensions' do
      expect(book.book_dimensions).to eq("H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}\"")
    end
  end

  describe '#shorten_description' do
    let(:book) { build_stubbed(:book, :long_description).decorate }

    context "when book description length is more than #{BookPresenter::SHORT_DESCRIPTION_LENGTH} chars" do
      it "adds link with Read more text" do
        expect(book.shorten_description).to include(I18n.t('read_more'))
      end
    end
  end

  describe '#preview_description' do
    context "when book description length is less than #{BookPresenter::SHORT_DESCRIPTION_LENGTH} chars" do
      let(:book) { build_stubbed(:book, description: 'some description').decorate }

      it "truncates description to #{BookPresenter::SHORT_DESCRIPTION_LENGTH}" do
        expect(book.preview_description.length).to eq(book.description.length)
      end
    end

    context "when book description length is more than #{BookPresenter::SHORT_DESCRIPTION_LENGTH} chars" do
      let(:book) { build_stubbed(:book, description: 'a' * 200).decorate }

      it "truncates description to #{BookPresenter::SHORT_DESCRIPTION_LENGTH}" do
        expect(book.preview_description.length).to eq(BookPresenter::SHORT_DESCRIPTION_LENGTH)
      end
    end
  end
end
