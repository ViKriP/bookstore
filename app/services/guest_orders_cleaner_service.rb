class GuestOrdersCleanerService
  def initialize(current_user, guest_session)
    @current_user = current_user
    @guest_session = guest_session
  end

  def call
    cleaning_guest_order

    cleaning_time
  end

  private

  def cleaning_time
    guest_orders_bad = GuestOrder.where('created_at >= :one_day_ago', :one_day_ago => Time.now - 1.day)

    guest_orders_bad.each { |guest_order| order_destroy(guest_order.order_id) }
  end

  def cleaning_guest_order
    order_in_progress = @current_user.orders.find_by(state: 'in_progress')
    return unless order_in_progress

    guest_order = GuestOrder.find_by(guest_id: @guest_session)
    return unless guest_order

    guest_order_clear(order_in_progress, guest_order)
  end

  def guest_order_clear(order_in_progress, guest_order)
    if order_in_progress.order_items.first #any?
      order_destroy(guest_order.order_id) if guest_order
    else
      order_item_to_user(guest_order, order_in_progress)

      order_destroy(guest_order.order_id)
    end
  end

  def order_item_to_user(current_guest_order, order_progress)
    guest_order_items = Order.find_by(id: current_guest_order.order_id).order_items

    return unless order_progress

    guest_order_items.each { |order_item| order_item.update(order_id: order_progress.id) }
  end

  def order_destroy(id)
    Order.where(id: id).destroy_all
  end
end
