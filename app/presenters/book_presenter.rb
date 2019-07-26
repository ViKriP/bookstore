class BookPresenter
  def initialize(params)
    @book_id = params
  end

  def reviews
    Book.find(@book_id).reviews.approved
  end
end
