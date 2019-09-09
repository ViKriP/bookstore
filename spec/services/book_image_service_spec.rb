require 'rails_helper'

describe BookImageService do
  describe '#image_url' do
    context 'when no image' do
      let(:book) { create(:book) }
      let(:book_without_image) { create(:book, images: nil) }

      it do
        service = described_class.new(book_without_image)
        expect(service.image_url).to eq 'noimage.png'
      end
    end

    context 'when there is image' do
      let(:book) { create(:book, images: ["url=/assets/default.png"]) }

      it do
        service = described_class.new(book)
        expect(service.image_url).to eq '/assets/default.png'
      end
    end
  end
end
