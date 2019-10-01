class CartController < ApplicationController
  load_and_authorize_resource class: Order

  def show; end

  def update
    coupon = CouponService.new(current_user_order, params[:code])

    return redirect_to cart_path, alert: I18n.t('invalid_coupon') unless coupon.coupon

    coupon.use

    redirect_to cart_path, notice: I18n.t('success_coupon_use')
  end
end
