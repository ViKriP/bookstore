class BookSortingService
  def initialize(params, books)
    @sort_type = params[:sort]&.split(' ')
    @books = books
  end

  def call
    @given_books = @books.presence || Book.all

    return @given_books.by_title(:asc) if @sort_type.blank?

    @given_books.public_send("by_#{@sort_type[0]}", @sort_type[1].to_sym)
  end
end
