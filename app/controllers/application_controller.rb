class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper Pagy::Frontend
  helper_method :current_user_order, :tmp_order

  def current_user_order
    order = Orders::FetchCurrent.new(current_user, session[:order_id], session.id).call
    session[:order_id] = order.id
    order
  end

  def tmp_order
    Order.new(false)
  end

  private

  def add_user_to_order
    GuestOrdersCleanerService.new(current_user, session.id).call
    current_user_order.update(user: current_user)
  end
end
