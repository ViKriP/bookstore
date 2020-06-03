require 'rails_helper'

describe BookImageService do
  describe '#image_url' do
    context 'when no image' do
      let(:book_without_image) { create(:book, images: nil) }

      it do
        service = described_class.new(book_without_image)
        expect(service.image_url).to eq('noimage.png')
      end
    end

    context 'when there is image' do
      let(:book) { create(:book) }

      it do
        service = described_class.new(book)
        expect(service.image_url).to eq(book.images.first.url)
      end
    end
  end
end
