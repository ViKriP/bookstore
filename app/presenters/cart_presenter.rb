class CartPresenter
  attr_reader :current_order

  def initialize(current_order, code)
    @current_order = current_order
    @code = code
    @coupon = coupon
  end

  def coupon
    Coupon.find_by(code: @code, active: true)
  end

  def update_order
    @current_order.update(discount: @coupon.discount) if @current_order
  end

  def deactivate_coupon
    @coupon.update(active: false) if @coupon
  end
end
