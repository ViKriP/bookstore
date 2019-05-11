class BookImageService
  def initialize(book)
    @book = book
  end

  def image_url
    if @book.images.any?
      @book.images.first.url
    else
      'noimage.png'
    end
  end
end
