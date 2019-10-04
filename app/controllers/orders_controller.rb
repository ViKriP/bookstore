class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @presenter = OrdersPresenter.new(filter_params[:filter])

    @filtered_orders = Orders::FilteredStateQuery.new(current_user.orders, filter_params[:filter]).call

    @orders = @filtered_orders
  end

  private

  def filter_params
    params.permit(:filter)
  end
end
