class HomepagePresenter
  def last_books
    Book.last(Book::CAROUSEL_LIMIT)
  end

  def best_sellers
    BestSellersService.new.call
  end
end
