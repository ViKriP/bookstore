class BooksController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index
    @presenter = BooksPresenter.new(params)

    sorted_books = BookSortingService.new(params).sort(@presenter.category&.books)
    @pagy, @books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)
  end

  def show
    @presenter = BookPresenter.new(@book)
  end
end
