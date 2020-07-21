class BookPresenter
  SHORT_DESCRIPTION_LENGTH = 150

  def initialize(book)
    @book = book
  end

  def reviews
    @book.reviews.approved
  end
end
