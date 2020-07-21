require 'rails_helper'

describe OrderItemService do
  describe '#call' do
    let(:order) { create(:order) }
    let(:book) { create(:book) }
    let(:params) { { quantity: 4, book_id: book.id } }
    let(:wrong_params) { { quantity: 4, book_id: nil } }

    it 'when create new orderitem is successfully' do
      service = described_class.new(order, params).call
      expect(service.quantity).to eql 4
    end

    it 'when is not order' do
      service = described_class.new(nil, params).call
      expect(service).to be_nil
    end

    it 'when is not params' do
      service = described_class.new(order, nil).call
      expect(service).to be_nil
    end

    it 'when params is wrong' do
      service = described_class.new(order, wrong_params).call
      expect(service).to be_nil
    end
  end
end