class ApplyCouponService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(order, code)
    @order = order
    @code = code
  end

  def call
    return unless @order && coupon

    ActiveRecord::Base.transaction do
      @order.update!(discount: coupon.discount)
      coupon.update!(active: false)
    end
  end

  private

  def coupon
    @coupon ||= Coupon.find_by(code: @code, active: true)
  end
end
