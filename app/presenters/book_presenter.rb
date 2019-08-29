class BookPresenter
  CAROUSEL_LIMIT = 3
  BESTSELLERS_LIMIT = 4
  SHORT_DESCRIPTION_LENGTH = 150

  def initialize(book)
    @book = book
  end

  def reviews
    Book.find(@book.id).reviews.approved
  end
end
