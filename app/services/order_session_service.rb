class OrderSessionService
  def initialize(current_user, session)
    @current_user = current_user
    @session = session
  end

  def call
    return guest_order unless @current_user

    user_order
  end

  private

  def guest_order
    session_order || create_order
  end

  def user_order
    return session_user_order if session_user_order

    return create_order unless session_order

    unfinished_user_order&.destroy

    session_order.update(user_id: @current_user.id)

    session_order
  end

  def session_order
    @session_order ||= Order.find_by(id: @session[:order_id])
  end

  def unfinished_user_order
    @unfinished_user_order ||= @current_user.orders.where(state: 'in_progress').last
  end

  def session_user_order
    @session_user_order ||= Order.find_by(id: @session[:order_id], user_id: @current_user.id)
  end

  def create_order
    order = Order.create(user_id: @current_user, number: checout_number)
    @session[:order_id] = order.id
    order
  end

  def checout_number
    I18n.t('checout_number', number: Time.zone.now.strftime('%Y%m%d%H%M%S'))
  end
end
