class CartController < ApplicationController
  load_and_authorize_resource class: Order
  before_action :set_order

  def show; end

  def update
    @order = current_user_order
    @coupon = Coupon.find_by(code: params[:code], active: true)
    if @coupon
      @order.update(discount: @coupon.discount)
      @coupon.update(active: false)
      redirect_to cart_path, notice: I18n.t('success_coupon_use')
    else
      redirect_to cart_path, alert: I18n.t('invalid_coupon')
    end
  end

  private

  def set_order
    @order = current_user_order
  end
end
