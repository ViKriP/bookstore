class CheckoutService
  def initialize(order, params)
    @order = order
    @params = params
  end

  def add_addresses
    #puts "=== #{@order.user.addresses.billing.methods} ==="
    @order.user.addresses.billing.create(billing_address_params)
    if @params[:use_billing] == 'true'
      @order.user.addresses.shipping.create(billing_address_params)
    else
      @order.user.addresses.shipping.create(shipping_address_params)
    end
    add_addresses_to_user if @order.valid?
  end

  def add_delivery
    @order.update(order_delivery_params)
  end

  def add_card
    #puts "=== #{@order.credit_card} = #{card_params} ==="
    @order.create_credit_card(card_params)
=begin    
    card = @order.user.credit_card
    if card
      card.update(card_params) #if @order.user.credit_card
    else
      card_new = CreditCard.new(card_params)
      card_new.save
    end
=end    
    #@order.create_credit_card(card_params)
  end

  private

  def billing_address_params
    @params.require(:order).require(:address).permit(
      :first_name, :last_name, :address, :zip, :city, :country, :phone
    )
  end

  def shipping_address_params
    @params.require(:order).require(:address).permit(
      :first_name, :last_name, :address, :zip, :city, :country, :phone
    )
  end

  def order_delivery_params
    @params.require(:order).permit(:delivery_id)
  end

  def card_params
    @params.require(:order).require(:credit_card_attributes).permit(:number, :name, :cvv, :exp_date)
  end

  def add_addresses_to_user
    #@order.user.billing_address = @order.billing_address.dup unless @order.user.billing_address
    #@order.user.shipping_address = @order.shipping_address.dup unless @order.user.shipping_address
    @order.user.addresses.billing = @order.user.addresses.billing.dup unless @order.user.addresses.billing
    @order.user.addresses.shipping = @order.user.addresses.shipping.dup unless @order.user.addresses.shipping
  end
end