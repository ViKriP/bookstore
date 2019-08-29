class CartController < ApplicationController
  load_and_authorize_resource class: Order
  before_action :set_order

  def show; end

  def update
    coupon = CouponService.new(@order, params[:code])

    return redirect_to cart_path, alert: I18n.t('invalid_coupon') unless coupon.coupon

    coupon.use
    coupon.deactivate

    redirect_to cart_path, notice: I18n.t('success_coupon_use')
  end

  private

  def set_order
    @order = current_user_order
  end
end
