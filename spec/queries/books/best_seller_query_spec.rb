require 'rails_helper'

describe Books::BestSellersQuery do
  def book_find(arr, title)
    arr.each do |item|
      return item if item.title == title
    end
  end

  def entity_save(arr)
    arr.each do |item|
      item.save
    end
  end

  describe '#call' do
    let(:orders) { create_list(:order, 4, state: 'in_queue') }
    let(:books) { create_list(:book, 40) }
    let(:categories) { create_list(:category, 4) }

    context 'when there are bestsellers in each of the four categories' do
      it 'four bestsellers determined' do
        book_categories = []
        start_i = 0
        categories.each_with_index do |category, index|
          for book_idx in start_i..start_i+9
            books[start_i].title = "Book_category_#{index + 1}" if book_idx == start_i
            book_categories.push(create(:book_category, category_id: category.id, book_id: books[book_idx].id))
          end
          start_i = book_idx + 1
        end

        order_items = []
        orders.each do |order|
          for order_item_idx in 1..4
            order_items.push(create(:order_item,
                                    order_id: order.id,
                                    book_id: book_find(books, "Book_category_#{order_item_idx}").id))
          end
        end

        entity_save(books)

        service = described_class.new.call
        (1..4).each { |i| expect(book_find(service, "Book_category_#{i}")).to be_a Book }
      end
    end

    context 'when best seller is in only one category' do
      it 'bestseller defined' do
        book_categories = []
        start_i = 0
        categories.each_with_index do |category, index|
          for book_idx in start_i..start_i+9
            books[book_idx].title = "Book_#{book_idx}" if index == 0
            book_categories.push(create(:book_category, category_id: category.id, book_id: books[book_idx].id))
          end
          start_i = book_idx + 1
        end

        order_items = []
        orders.each_with_index do |order, index|

          index <= 1 ? book_idx = 1 : book_idx = index
          order_items.push(create(:order_item,
                                  order_id: order.id,
                                  book_id: book_find(books, "Book_#{book_idx}").id))
        end

        entity_save(books)

        service = described_class.new.call
        expect(book_find(service, "Book_1")).to be_a Book
      end
    end
  end
end
