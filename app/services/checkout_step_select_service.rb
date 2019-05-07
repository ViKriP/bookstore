class CheckoutStepSelectService
  def initialize(order)
    @order = order
  end

  def check
    return :address unless addresses_exist?

    return :delivery unless delivery_exist?

    return :payment unless credit_card_exist?

    return :confirm unless confirmed?

    :complete
  end

  private

  def addresses_exist?
    @order.billing_address && @order.shipping_address
  end

  def delivery_exist?
    @order.delivery
  end

  def credit_card_exist?
    @order.credit_card
  end

  def confirmed?
    @order.state == 'in_queue'
  end
end