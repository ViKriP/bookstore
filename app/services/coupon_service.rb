class CouponService
  def initialize(order, code)
    @order = order
    @code = code
  end

  def coupon
    @coupon ||= Coupon.find_by(code: @code, active: true)
  end

  def use
    return unless @order && coupon

    @order.update(discount: coupon.discount)

    coupon.update(active: false)
  end
end
