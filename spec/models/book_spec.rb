require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to have_and_belong_to_many(:categories) }
  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_numericality_of(:price) }
  it { is_expected.to validate_numericality_of(:quantity) }
  it { is_expected.to validate_numericality_of(:year) }

  #let(:book) { create(:book) }

  describe '#ended?' do
    context 'when there are some books in stock' do
      it do
        book = create(:book)
        expect(book.ended?).to be false
      end
    end

    context 'when there are no books' do
      it do
        book = create(:book, quantity: 0)
        expect(book.ended?).to be true
      end
    end
  end
end
