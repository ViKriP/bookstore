class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @presenter = OrdersPresenter.new(current_user.orders, params)
  end
end
