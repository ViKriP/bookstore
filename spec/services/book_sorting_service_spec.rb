require 'rails_helper'

describe BookSortingService do
  let(:params_title_asc) { { sort: 'title_asc' } }
  let(:params_title_desc) { { sort: 'title_desc' } }
  let(:params_price_asc) { { sort: 'price_asc' } }
  let(:params_price_desc) { { sort: 'price_desc' } }
  let(:params_date_asc) { { sort: 'date_asc' } }
  let(:params_popular) { { sort: 'popular' } }
  let(:params_wrong) { { sort: 'wrong' } }

  describe '#sort' do
    let(:books) { Book.where(id: create_list(:book, 5).map(&:id)) }

    BookSortingService::SORT_TITLES.each do |phrase|
      it "returns collection sorted of #{phrase[0]}" do
        expect(described_class.new(send("params_#{phrase[0]}")).sort(books)).to be_a ActiveRecord::Relation
      end
    end
  end

  describe '#sort_title' do
    BookSortingService::SORT_TITLES.each do |phrase|
      it '' do
        expect(described_class.new(send("params_#{phrase[0]}")).sort_title).to be(phrase[1])
      end
    end

    it 'should returns default if wrong param' do
      expect(described_class.new(params_wrong).sort_title).to be(BookSortingService::SORT_TITLES[:title_asc])
    end
  end
end
