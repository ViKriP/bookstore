require 'rails_helper'

describe Books::ShowPresenter do
  describe '#reviews' do
    #let(:params_with_filter) { { sort_with: 'title desc' } }
    let(:reviews) { create_list(:review, 5) }

    xit 'returns collection' do
      #create_list(:book, 5)
      #expect(BookSortingService.new(params_with_filter).sort(Book.all)).to be_a ActiveRecord::Relation
      expect(described_class.new(1).reviews).to be_a ActiveRecord::Relation
    end
  end
end
