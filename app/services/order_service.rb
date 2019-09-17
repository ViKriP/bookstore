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

    destroy_order(unfinished_user_order) if unfinished_user_order
    #unfinished_user_order.destroy
    session_order.update(user_id: @current_user.id)
    session_order
  end

  def session_order
    Order.find_by(id: @session_order_id)
  end

  def unfinished_user_order
    @current_user.orders.where(state: 'in_progress').last
  end

  def session_user_order
    Order.find_by(id: @session_order_id, user_id: @current_user.id)
  end

  def create_order
    order = Order.new(user_id: @current_user, number: checout_number)
    order.save(validate: false)
    order
  end

  def destroy_order(id)
    Order.where(id: id).destroy_all
  end

  def checout_number
    '#R' + Time.zone.now.strftime('%Y%m%d%H%M%S')
  end
end
