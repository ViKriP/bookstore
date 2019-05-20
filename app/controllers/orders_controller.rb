class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @index_presenter = Orders::IndexPresenter.new(current_user.orders, params)
  end

  def show
    @order = current_user.orders.find_by!(id: params[:id])
  end
end
