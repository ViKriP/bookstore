module Books
  class IndexPresenter
    include Pagy::Backend

    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def categories
      Category.all
    end

    def category
      Category.find_by(id: @params[:category_id])
    end

    def pagy_sort
      sorted_books = BookSortingService.new(@params).sort(category&.books)

      @pagy, @books = pagy(sorted_books, items: Book::BOOKS_PER_PAGE)
    end

    def pagy_books
      pagy_sort
      @pagy
    end

    def books
      pagy_sort
      @books
    end

    def sort_title
      BookSortingService.new(@params).sort_title
    end
  end
end
