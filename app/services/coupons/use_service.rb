class Coupons::UseService
  def initialize(order, coupon)
    @order = order
    @coupon = coupon
  end

  def call
    return unless @order && @coupon

    @order.update(discount: @coupon.discount)
    deactivate
  end

  private

  def deactivate
    @coupon.update(active: false)
  end
end
