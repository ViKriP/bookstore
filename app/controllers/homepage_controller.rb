class HomepageController < ApplicationController
  def index
    @last_books = Book.last(Book::CAROUSEL_LIMIT)
    @best_sellers = BestSellersService.new.call #Book.offset(Book.count - 4)
    @books = Book.all
  end
end
