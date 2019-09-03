class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_order

  def current_user_order
    order = OrderService.new(current_user, session).call
    session[:order_id] = order.id
    order
  end

  private

  def add_user_to_order
    OrdersCleanerService.new.call

    current_user_order.update(user: current_user)
  end
end
