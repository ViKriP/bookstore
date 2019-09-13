class Books::BestSellersQuery
  BESTSELLERS_LIMIT = 4

  def initialize(limit = BESTSELLERS_LIMIT)
    @limit = limit
  end

  def call
    bestseller = []

    Category.distinct.each_with_index do |item, idx|
      bestseller.push(bestseller_category(item.id)) if idx <= @limit - 1
    end

    bestseller.compact
  end

  private

  def bestseller_category(category)
    Book.joins(:orders, :categories)
        .where.not(orders: { state: I18n.t('order_state.in_progress') })
        .where(book_categories: { category_id: category.to_s })
        .group(:id).order(Arel.sql('COUNT(orders.id) DESC'))
        .limit(1).first
  end
end
