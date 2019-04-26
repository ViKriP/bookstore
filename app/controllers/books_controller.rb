class BooksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @books_index = Books::IndexPresenter.new(params)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.approved
  end
end
