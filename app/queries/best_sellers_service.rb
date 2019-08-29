class BestSellersService
  def initialize(limit = BookPresenter::BESTSELLERS_LIMIT)
    @limit = limit
  end

  def call
    Book.left_joins(:orders).group(:id).order(Arel.sql('COUNT(orders.id) DESC')).limit(@limit)
  end
end
