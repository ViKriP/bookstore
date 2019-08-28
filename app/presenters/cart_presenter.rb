class CartPresenter
  def initialize(code)
    @code = code
  end

  def coupon
    Coupon.find_by(code: @code, active: true)
  end
end
