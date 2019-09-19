class OrderService
  def initialize(current_user, session)
    @current_user = current_user
    @session_order_id = session[:order_id]
  end

  def call
    return guest_order unless @current_user

    user_order
  end

  def order_items
    call.order_items.order(:created_at)
  end

  private

  def guest_order
    session_order || create_order
  end

  def user_order
    return session_user_order if session_user_order

    return create_order unless session_order

    unfinished_user_order.destroy if unfinished_user_order

    session_order.update(user_id: @current_user.id)

    session_order
  end

  def session_order
    @session_order ||= Order.find_by(id: @session_order_id)
  end

  def unfinished_user_order
    @unfinished_user_order ||= @current_user.orders.where(state: 'in_progress').last
  end

  def session_user_order
    @session_user_order ||= Order.find_by(id: @session_order_id, user_id: @current_user.id)
  end

  def create_order
    Order.create(user_id: @current_user, number: checout_number)
  end

  def checout_number
    '#R' + Time.zone.now.strftime('%Y%m%d%H%M%S')
  end
end
