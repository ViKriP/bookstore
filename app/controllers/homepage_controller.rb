class HomepageController < ApplicationController
  #before_action :authenticate_user!

  def index
    @last_books = Book.last(Book::CAROUSEL_LIMIT)
    @best_sellers = Book.offset(Book.count - 4)
    @books = Book.all
  end
end
