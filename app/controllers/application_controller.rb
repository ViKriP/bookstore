class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper Pagy::Frontend
  helper_method :current_user_order

  def current_user_order
    order = Orders::FetchCurrent.new(current_user, session[:order_id]).call
    session[:order_id] = order.id
    order
  end

  private

  def add_user_to_order
    current_user_order.update(user: current_user)
  end
end
