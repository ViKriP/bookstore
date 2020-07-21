require 'rails_helper'

describe BookSortingService do
  let(:params_title_asc) { { sort: 'title asc' } }
  let(:params_title_desc) { { sort: 'title desc' } }
  let(:params_price_asc) { { sort: 'price asc' } }
  let(:params_price_desc) { { sort: 'price desc' } }
  let(:params_created_at_desc) { { sort: 'created_at desc' } }
  let(:params_popular_desc) { { sort: 'popular desc' } }
  let(:params_wrong) { { sort: '' } }

  describe '#call' do
    let!(:book_1) { create(:book, title: 'A', price: 40, created_at: '2019-12-17 10:00:00') }
    let!(:book_2) { create(:book, title: 'B', price: 30, created_at: '2019-12-17 11:00:00') }
    let!(:book_3) { create(:book, title: 'C', price: 20, created_at: '2019-12-17 12:00:00') }
    let!(:book_4) { create(:book, title: 'D', price: 10, created_at: '2019-12-17 13:00:00') }

    let(:order_1) { create(:order, state: 'in_queue') }
    let(:order_2) { create(:order, state: 'in_queue') }

    let!(:order_item_1) { create(:order_item, order_id: order_1.id, book_id: book_2.id) }
    let!(:order_item_2) { create(:order_item, order_id: order_1.id, book_id: book_3.id) }
    let!(:order_item_3) { create(:order_item, order_id: order_2.id, book_id: book_2.id) }

    def sorted_result(phrase)
      case phrase
      when 'params_title_asc' then [ book_1, book_2, book_3, book_4 ]
      when 'params_title_desc' then [ book_4, book_3, book_2, book_1 ]
      when 'params_price_asc' then [ book_4, book_3, book_2, book_1 ]
      when 'params_price_desc' then [ book_1, book_2, book_3, book_4 ]
      when 'params_created_at_desc' then [ book_4, book_3, book_2, book_1 ]
      end
    end

    context 'when params are correct' do
      BooksPresenter::SORT_TITLES.each do |phrase|
        if phrase[0].to_s != 'popular_desc'
          it "returns collection sorted of #{phrase[0]}" do
            service = described_class.new(public_send("params_#{phrase[0]}"), Book.all)

            expect(service.call.all).to eq sorted_result("params_#{phrase[0]}")
          end
        end
      end

      it "returns collection sorted of popular_desc" do
        service = described_class.new(params_popular_desc, Book.all)
  
        expect(service.call.first).to eq book_2
      end
    end

    context 'when params are wrong' do
      it 'returns collection sorted of title_asc' do
        service = described_class.new(params_wrong, Book.all)

        expect(service.call.all).to eq [ book_1, book_2, book_3, book_4 ]
      end
    end
  end
end
