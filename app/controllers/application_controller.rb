class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_order

  def current_user_order
    OrderSessionService.new(current_user, session).call
  end

  private

  def add_user_to_order
    current_user_order.update(user: current_user)
  end
end
