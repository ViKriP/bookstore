class BooksController < ApplicationController
  include Pagy::Backend

  load_and_authorize_resource :book, exept: :index
  load_and_authorize_resource :category, only: :index
  before_action :preload_books, only: :index

  def index
    @presenter = BooksPresenter.new(params_sort)

    sorted_books = BookSortingService.new(params_sort, @books).call
    @pagy, @books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)
  end

  def show
    @presenter = BookPresenter.new(@book)
  end

  private

  def preload_books
    @books = @category.nil? ? Book.all : Book.by_category(params[:category_id])
  end

  def params_sort
    params.permit(:sort, :category_id)
  end
end
