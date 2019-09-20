class BookSortingService
  def initialize(params, books)
    @sort_type = params[:sort].split(' ') if params[:sort]
    @books = books
  end

  def call
    @given_books = @books || Book.all

    return Book.none unless @given_books

    begin
      @given_books.public_send("by_#{@sort_type[0]}", @sort_type[1].to_sym)
    rescue StandardError
      @given_books.by_title(:asc)
    end
  end
end
