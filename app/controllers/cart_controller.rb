class CartController < ApplicationController
  #load_and_authorize_resource :class => Order

  def show
    @order = current_user_order
    @order_items = Orders::ItemsPresenter.new.sort_items(@order)
  end

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
end
