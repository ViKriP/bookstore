class HomepagePresenter
  CAROUSEL_LIMIT = 3

  def last_books
    Book.last(CAROUSEL_LIMIT)
  end

  def best_sellers
    Books::BestSellersQuery.new.call
  end
end
