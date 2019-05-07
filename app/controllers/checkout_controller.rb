class CheckoutController < ApplicationController
  before_action :set_order
  before_action :check_cart_emptiness

  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    actual_step = CheckoutStepSelectService.new(@order).check
    jump_to(actual_step) if checkout_way_is_not_ok?(step, actual_step)

    case step
    when :address then select_user_defined_address
    when :delivery then @deliveries = Delivery.all
    when :payment then @order.build_credit_card
    when :complete then end_checkout
    end
    render_wizard
  end

  def update
    case step
    when :address then CheckoutService.new(@order, params).add_addresses
    when :delivery then CheckoutService.new(@order, params).add_delivery
    when :payment then CheckoutService.new(@order, params).add_card
    when :confirm
      @order.confirm
      @order.save
    end
    render_wizard(@order)
  end

  private

  def set_order
    @order = current_user_order
  end

  def check_cart_emptiness
    redirect_to root_path if @order.order_items.count.zero?
  end

  def checkout_way_is_not_ok?(step, actual_step)
    (step != actual_step) && past_step?(actual_step)
  end

  def select_user_defined_address
    @billing_address = current_user.billing_address || @order.build_billing_address
    @shipping_address = current_user.shipping_address || @order.build_shipping_address
  end

  def end_checkout
    session.delete(:order_id)
    add_user_to_order
  end
end
