require 'rails_helper'

describe BookPresenter do
  describe '#reviews' do
    let(:review) { create(:review) }

    it 'returns collection' do
      expect(described_class.new(review.book).reviews).to be_a ActiveRecord::Relation
    end
  end
end
