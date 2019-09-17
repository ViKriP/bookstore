class BookSortingService
  def initialize(params, books)
    @sort_type = params[:sort].split(' ') if params[:sort]
    @books = books
  end

  def call
    @given_books = @books || Book.all

    return unless @given_books

    return @given_books.title(:asc) unless @sort_type

    @given_books.send(@sort_type[0], @sort_type[1].to_sym)
  end
end
