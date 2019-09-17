class BookImageService
  def initialize(book)
    @book = book
  end

  def image_url
    return 'noimage.png' unless @book.images.any?

    @book.images.first.url
  end
end
