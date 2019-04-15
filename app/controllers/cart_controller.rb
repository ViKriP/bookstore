class CartController < ApplicationController
  before_action :initial_order

  def show; end

  def update
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon
      @order.update(discount: @coupon.discount)
      @coupon.destroy
      redirect_to cart_path, notice: I18n.t('success_coupon_use')
    else
      redirect_to cart_path, alert: I18n.t('invalid_coupon')
    end
  end

  private

  def initial_order
    @order = current_user_order
    @order_items = @order.order_items.sort_by(&:created_at)
  end
end
