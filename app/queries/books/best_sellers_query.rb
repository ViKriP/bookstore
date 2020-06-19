module Books
  class BestSellersQuery
    BESTSELLERS_LIMIT = 4

    def initialize(limit = BESTSELLERS_LIMIT)
      @limit = correct_limit(limit)
    end

    def call
      return unless Category.any?

      bestsellers = []

      Category.distinct.limit(@limit).each do |category|
        bestsellers.push(bestseller_category(category.id))
      end

      bestsellers.any? ? bestsellers.compact : nil
    end

    private

    def bestseller_category(category_id)
      Book.joins(:orders, :categories)
          .where.not(orders: { state: 'in_progress' })
          .where(book_categories: { category_id: category_id })
          .group(:id)
          .order(Arel.sql('SUM(order_items.quantity) DESC'))
          .limit(1).first
    end

    def correct_limit(limit)
      limit.is_a?(Integer) && limit.positive? ? limit : 1
    end
  end
end
