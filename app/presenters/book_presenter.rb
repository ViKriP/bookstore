class BookPresenter
  def initialize(book)
    @book = book
  end

  def reviews
    Book.find(@book.id).reviews.approved
  end
end
