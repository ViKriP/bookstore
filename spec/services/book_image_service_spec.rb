require 'rails_helper'

describe BookImageService do
  describe '#image_url' do
    context 'when no image' do
      let(:book) { create(:book) }

      it do
        service = described_class.new(book)
        expect(service.image_url).to eq 'noimage.png'
      end
    end

    context 'when there is image' do
      let(:book) { create(:book, images: ["url=/assets/default.jpg"]) }

      it do
        service = described_class.new(book)
        expect(service.image_url).to eq '/assets/default.jpg'
      end
    end

  end
end