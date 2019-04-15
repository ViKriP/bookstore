class BookSortingService
  SORT_TITLES = {
    date_asc: I18n.t('newest_first'),
    popular: I18n.t('popular_first'),
    price_asc: I18n.t('price_asc'),
    price_desc: I18n.t('price_desc'),
    title_asc: I18n.t('title_asc'),
    title_desc: I18n.t('title_desc')
  }.freeze

  def initialize(params)
    @sort_type = params[:sort]&.to_sym
  end

  def sort(books)
    @given_books = books || Book.all
    case @sort_type
    when :date_asc then @given_books.order('created_at asc')
    when :popular then @given_books.left_joins(:orders).group(:id).order(Arel.sql('COUNT(orders.id) DESC'))
    when :price_asc then @given_books.order('price asc')
    when :price_desc then @given_books.order('price desc')
    when :title_asc then @given_books.order('title asc')
    when :title_desc then @given_books.order('title desc')
    else @given_books.order('title asc')
    end
  end

  def sort_title
    return SORT_TITLES[:title_asc] unless @sort_type

    SORT_TITLES[@sort_type]
  end
end