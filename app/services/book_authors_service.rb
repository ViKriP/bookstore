class BookAuthorsService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(book)
    @book = book
  end

  def call
    @book.authors.map(&:id) if @book.authors.presence
  end
end
