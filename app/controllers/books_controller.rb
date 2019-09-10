class BooksController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource

  def index
    @presenter = BooksPresenter.new(params_sort)

    sorted_books = BookSortingService.new(params_sort).sort(@presenter.category&.books)
    @pagy, @books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)
  end

  def show
    @presenter = BookPresenter.new(@book)
  end

  private

  def params_sort
    params.permit(:sort, :category_id)
  end
end
