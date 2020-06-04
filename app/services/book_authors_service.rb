class BookAuthorsService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(book)
    @book = book
  end

  def call
    @book.authors.pluck(:id) if @book.authors.presence
  end
end
