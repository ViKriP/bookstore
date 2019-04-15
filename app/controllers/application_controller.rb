class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper Pagy::Frontend
  helper_method :current_user_order

  def current_user_order
    order = unfinished_order || Order.find_or_create_by(id: session[:order_id])
    session[:order_id] = order.id
      puts "----------| #{session.id} = #{session[:order_id]} = #{session.keys}|----------------------"
    order
  end

  private

  def unfinished_order
    current_user.orders.where(state: 'in_progress').last if current_user
  end

  def add_user_to_order
    current_user_order.update(user: current_user)
  end
end
