class BookCategoryService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(book)
    @book = book
  end

  def call
    @book.categories.first.id if @book.categories.presence
  end
end
