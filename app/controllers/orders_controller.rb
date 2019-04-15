class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @orders = OrdersFilterService.new(current_user.orders, params).filter.order(:id)
    @filter_title = OrdersFilterService.new(current_user.orders, params).filter_title
  end

  def show
    @order = current_user.orders.find_by!(id: params[:id])
    @order_items = @order.order_items
  end
end
