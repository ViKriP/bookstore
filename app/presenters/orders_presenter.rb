class OrdersPresenter
  ORDER_SORT_TITLES = {
    all: I18n.t('order_filters.all'),
    in_queue: I18n.t('order_filters.in_queue'),
    in_delivery: I18n.t('order_filters.in_delivery'),
    delivered: I18n.t('order_filters.delivered'),
    canceled: I18n.t('order_filters.canceled')
  }.freeze

  def initialize(orders, filter)
    @orders = orders
    @filter = filter&.to_sym
  end

  def filter_title
    return ORDER_SORT_TITLES.fetch(:all) unless ORDER_SORT_TITLES.has_key?(@filter)

    ORDER_SORT_TITLES.fetch(@filter)
  end
end
