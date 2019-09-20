class Books::BestSellersQuery
  BESTSELLERS_LIMIT = 4

  def initialize(limit = BESTSELLERS_LIMIT)
    @limit = limit
  end

  def call
    bestseller = []

    Category.distinct.each_with_index do |category, idx|
      bestseller.push(bestseller_category(category.id)) if idx <= @limit - 1
    end

    bestseller.compact
  end

  private

  def bestseller_category(category_id)
    Book.joins(:orders, :categories)
        .where.not(orders: { state: 'in_progress' })
        .where(book_categories: { category_id: category_id })
        .group(:id).order(Arel.sql('COUNT(order_items.quantity) DESC'))
        .limit(1).first
  end
end
