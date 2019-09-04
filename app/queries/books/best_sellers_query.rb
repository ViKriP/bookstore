class Books::BestSellersQuery
  BESTSELLERS_LIMIT = 4

  def initialize(limit = BESTSELLERS_LIMIT)
    @limit = limit
  end

  def call
    #Book.left_joins(:orders).group(:id).order(Arel.sql('COUNT(orders.id) DESC')).limit(@limit)

=begin
Order state in_queue
OrderItem
Book COUNT
=end
    bestseller = Book.left_joins(:orders).where(orders: { state: 'in_queue'}).group(:id).order(Arel.sql('COUNT(orders.id) DESC')).limit(@limit)

    #bestseller.each { |item| puts "= #{item.id} ="  }
    #bestseller
  end
end
