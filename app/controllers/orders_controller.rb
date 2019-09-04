class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @presenter = OrdersPresenter.new(current_user.orders, filter_params[:filter])
  end

  private

  def filter_params
    params.permit(:filter)
  end
end
