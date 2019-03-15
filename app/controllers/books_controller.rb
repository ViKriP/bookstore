class BooksController < ApplicationController
  include Pagy::Backend

  def index
    @categories = Category.all
    @category = Category.find_by(id: params[:category_id])
    sorted_books = BookSortingService.new(params).sort(@category&.books)
    @pagy, @books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)
    @sort_title = BookSortingService.new(params).sort_title
  end

  #def show
  #  @book = Book.find(params[:id])
  #end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved
  end
end
