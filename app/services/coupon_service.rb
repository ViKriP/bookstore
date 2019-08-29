class CouponService
  def initialize(order, code)
    @order = order
    @code = code
    @coupon = coupon
  end

  def coupon
    Coupon.find_by(code: @code, active: true)
  end

  def use
    @order.update(discount: @coupon.discount) if  @order && @coupon
  end

  def deactivate
    @coupon.update(active: false) if @coupon
  end
end
