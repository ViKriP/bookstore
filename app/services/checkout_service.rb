class CheckoutService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def process_address
    @order.create_billing_address(billing_address_params)

    if @params[:use_billing] == 'true'
      @order.create_shipping_address(billing_address_params)
    else
      @order.create_shipping_address(shipping_address_params)
    end

    add_addresses_to_user if @order.valid?
  end

  def process_delivery
    @order.update(order_delivery_params)
  end

  def process_payment
    @order.create_credit_card(card_params)
  end

  def process_confirm
    @order.confirm
    @order.save
  end

  private

  def billing_address_params
    @params.require(:order).require(:billing_address_attributes).permit(
      :first_name, :last_name, :address, :zip, :city, :country, :phone
    )
  end

  def shipping_address_params
    @params.require(:order).require(:shipping_address_attributes).permit(
      :first_name, :last_name, :address, :zip, :city, :country, :phone
    )
  end

  def order_delivery_params
    @params.require(:order).permit(:delivery_id)
  end

  def card_params
    params = @params.require(:order).require(:credit_card_attributes).permit(:last4, :name, :exp_month, :exp_year)

    {
      last4: params[:last4],
      name: params[:name],
      exp_month: params[:exp_month],
      exp_year: params[:exp_year]
    }
  end

  def add_addresses_to_user
    @order.user.billing_address = @order.billing_address.dup unless @order.user.billing_address
    @order.user.shipping_address = @order.shipping_address.dup unless @order.user.shipping_address
  end
end
