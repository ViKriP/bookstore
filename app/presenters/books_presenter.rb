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
    @params = params[:category_id]
    @sort_type = params[:sort].gsub(' ', '_').to_sym if params[:sort]
  end

  def categories
    Category.all
  end

  def category
    Category.find_by(id: @params) if @params
  end

  def sort_title
    return SORT_TITLES[:title_asc] unless SORT_TITLES[@sort_type]

    SORT_TITLES[@sort_type]
  end
end
