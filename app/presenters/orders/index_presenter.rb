module Orders
  class IndexPresenter
    ORDER_SORT_TITLES = {
      all: I18n.t('order_filters.all'),
      in_queue: I18n.t('order_filters.in_queue'),
      in_delivery: I18n.t('order_filters.in_delivery'),
      delivered: I18n.t('order_filters.delivered'),
      canceled: I18n.t('order_filters.canceled')
    }.freeze

    def initialize(orders, params)
      #puts "--- #{params} ---"
      @orders = orders
      @filter = params[:filter]&.to_sym
    end

    def filter
      return @orders.where.not(state: 'in_progress') unless @filter

      @orders.where(state: @filter)
    end

    def filter_title
      return ORDER_SORT_TITLES[:all] unless @filter

      ORDER_SORT_TITLES[@filter]
    end
  end
end
