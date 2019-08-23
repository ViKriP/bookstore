class OrdersCleanerService
  def call
    orders_bad = Order.where("created_at <= :one_day_ago and user_id is NULL",
                                   one_day_ago: Time.zone.now - 1.day)

    orders_bad.each { |order| Order.where(id: order.id).destroy_all }
  end
end
