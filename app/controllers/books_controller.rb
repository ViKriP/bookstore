class BooksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @books_index = Books::IndexPresenter.new(params)
  end

  def show
    @books_show = Books::ShowPresenter.new(params[:id])
  end
end
