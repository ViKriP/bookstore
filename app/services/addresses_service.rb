class AddressesService
  def initialize(user)
    @user = user
  end

  def call
    @user.billing_address || @user.build_billing_address
    @user.shipping_address || @user.build_shipping_address
  end
end
