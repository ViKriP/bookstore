class BookSortingService
  def initialize(params, books)
    @sort_type = params[:sort].split(' ') if params[:sort]
    @books = books
  end

  def call
    @given_books = @books || Book.all

    return unless @given_books

    @given_books.send("by_#{@sort_type[0]}", @sort_type[1].to_sym)

    rescue
      @given_books.by_title(:asc)
  end
end
