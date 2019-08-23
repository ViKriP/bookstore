class GuestOrdersCleanerService
  def call
    guest_orders_bad = Order.where("created_at <= :one_day_ago and user_id is NULL",
                                   one_day_ago: Time.zone.now - 1.day)

    guest_orders_bad.each { |guest_order| destroy_order(guest_order.id) }
  end

  private

  def destroy_order(id)
    Order.where(id: id).destroy_all
  end
end
