class CartController < ApplicationController
  load_and_authorize_resource class: Order

  def show
    @order = current_user_order
  end

  def update
    if ApplyCouponService.call(current_user_order, params[:code])
      flash[:notice] = I18n.t('success_coupon_use')
    else
      flash[:alert] = I18n.t('invalid_coupon')
    end

    redirect_to cart_path
  end
end
