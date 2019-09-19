class OrdersCleanerService
  def call
    orders_bad = Order.where('created_at <= :one_day_ago and user_id is NULL',
                             one_day_ago: 1.day.ago)

    orders_bad.destroy_all
  end
end
