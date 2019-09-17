class BooksPresenter
  SORT_TITLES = {
    created_at_desc: I18n.t('newest_first'),
    popular_desc: I18n.t('popular_first'),
    price_asc: I18n.t('price_asc'),
    price_desc: I18n.t('price_desc'),
    title_asc: I18n.t('title_asc'),
    title_desc: I18n.t('title_desc')
  }.freeze

  def initialize(params)
    @category_id = params[:category_id]
    @sort_type = params[:sort]&.tr(' ', '_')&.to_sym
  end

  def categories
    Category.all
  end

  def category
    Category.find_by(id: @category_id) if @category_id
  end

  def sort_title
    return SORT_TITLES.fetch(:title_asc) unless SORT_TITLES.has_key?(@sort_type&.to_sym)

    SORT_TITLES.fetch(@sort_type&.to_sym)
  end
end
