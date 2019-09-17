require 'rails_helper'

describe BookSortingService do
  let(:params_title_asc) { { sort: 'title asc' } }
  let(:params_title_desc) { { sort: 'title desc' } }
  let(:params_price_asc) { { sort: 'price asc' } }
  let(:params_price_desc) { { sort: 'price desc' } }
  let(:params_created_at_desc) { { sort: 'created_at desc' } }
  let(:params_popular_desc) { { sort: 'popular desc' } }
  let(:params_wrong) { { sort: 'wrong' } }

  describe '#call' do
    let(:books) { Book.where(id: create_list(:book, 5).map(&:id)) }

    context 'when params are correct' do
      BooksPresenter::SORT_TITLES.each do |phrase|
        it "returns collection sorted of #{phrase[0]}" do
          service = described_class.new(send("params_#{phrase[0]}"), books)

          expect(service.call).to be_a ActiveRecord::Relation
        end
      end
    end

    context 'when params are wrong' do
      it 'returns collection sorted of title_asc' do
        service = described_class.new(params_wrong, books)

        expect(service.call).to be_a ActiveRecord::Relation
      end
    end
  end
end
