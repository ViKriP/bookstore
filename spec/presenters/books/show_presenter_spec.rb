require 'rails_helper'

describe Books::ShowPresenter do
  describe '#reviews' do
    let(:review) { create(:review) }

    it 'returns collection' do
      expect(described_class.new(review.book.id).reviews).to be_a ActiveRecord::Relation
    end
  end
end
